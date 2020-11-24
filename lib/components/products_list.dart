import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/filter_widget.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsList extends StatefulWidget {
  final String category;
  final String searchTerm;
  final String types;

  ProductsList({Key key, this.category, this.searchTerm, this.types}) {}

  @override
  _ProductsListState createState() => _ProductsListState();

  static _ProductsListState of(BuildContext context) {
    final _ProductsListState navigator = context
        // ignore: deprecated_member_use
        .ancestorStateOfType(const TypeMatcher<_ProductsListState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a ProductsList.');
      }
      return true;
    }());

    return navigator;
  }
}

class _ProductsListState extends State<ProductsList> {
  int page = 1;
  ScrollController _scrollController;
  ProductsListBloc productsListBloc;

  @override
  void initState() {
    super.initState();
    productsListBloc = ProductsListBloc();
    productsListBloc.searchTerm.value = widget.searchTerm;
    productsListBloc.types.value = widget.types;
    productsListBloc.currentCategory.value = widget.category;
    productsListBloc..getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    productsListBloc.drainStream();
    productsListBloc.drainCategoryStream();
    brandsBloc.drainStream();
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition > triggerFetchMoreSize) {
        Meta meta = productsListBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          productsListBloc.page.value = page;
          productsListBloc..getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productsListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(ProductResponse data) {
    List<Product> products = data.products;
    return Scaffold(
      body: products.length > 0
          ? Container(
              padding: EdgeInsets.only(top: 18),
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index], width: 200.0);
                  }))
          : Center(
              child: Text(tr("No Products Found")),
            ),
      bottomNavigationBar: Row(children: <Widget>[
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(color: Colors.white),
          child: FlatButton.icon(
            icon: Icon(Icons.sort),
            label: Flexible(
                fit: FlexFit.loose,
                child: Container(
                  color: Colors.white,
                  child: Text(
                    tr("SORT BY"),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            onPressed: () {
              _showSortProduct(context);
            },
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(color: Colors.white),
          child: FlatButton.icon(
            icon: Icon(Icons.filter_list),
            label: Flexible(
                fit: FlexFit.loose,
                child: Container(
                  child: Text("FILTER", overflow: TextOverflow.ellipsis),
                )),
            onPressed: () {
              _showFilterProduct(context);
            },
          ),
        ),
      ]),
    );
  }

  void _showSortProduct(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .70,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text("SORT BY",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                          title: Text("Default",
                              style: TextStyle(
                                  fontWeight:
                                      productsListBloc.sortBy.value == "default"
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, "default");
                          }),
                      ListTile(
                          title: Text("Popularity",
                              style: TextStyle(
                                  fontWeight: productsListBloc.sortBy.value ==
                                          "popularity"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'popularity');
                          }),
                      ListTile(
                          title: Text("Low - High Price",
                              style: TextStyle(
                                  fontWeight: productsListBloc.sortBy.value ==
                                          "price_asc"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'price_asc');
                          }),
                      ListTile(
                          title: Text("High - Low Price",
                              style: TextStyle(
                                  fontWeight: productsListBloc.sortBy.value ==
                                          "price_desc"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'price_desc');
                          }),
                      ListTile(
                          title: Text("Average Rating",
                              style: TextStyle(
                                  fontWeight: productsListBloc.sortBy.value ==
                                          "average_rating"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'average_rating');
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  sortProducts(context, String sortBy) {
    productsListBloc.sortBy.value = sortBy;
    productsListBloc.getProducts();
    Navigator.of(context).pop();
  }

  void _showFilterProduct(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return FilterWidget(productsListBloc: productsListBloc);
        });
  }
}