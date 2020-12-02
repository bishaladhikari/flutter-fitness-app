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

import 'custom_error_widget.dart';

class ProductsList extends StatefulWidget {
  final String category;
  final String searchTerm;
  final String types;
  final String storeSlug;

  ProductsListBloc productsListBloc;

  ProductsList(
      {Key key, this.category, this.searchTerm, this.types, this.storeSlug}) {
    productsListBloc = ProductsListBloc();
    productsListBloc.searchTerm.value = searchTerm;
//    productsListBloc.currentCategory.value = category;
//    productsListBloc..getProducts();
//    categoryBloc.productsListBloc = _productsListBloc;
//    super(key: key);
  }

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

  @override
  void initState() {
    super.initState();
    widget.productsListBloc.searchTerm.value = widget.searchTerm;
    widget.productsListBloc.types.value = widget.types;
    widget.productsListBloc.storeSlug.value = widget.storeSlug;
    widget.productsListBloc.currentCategory.value = widget.category;
    widget.productsListBloc..getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    widget.productsListBloc.drainStream();
    widget.productsListBloc.drainCategoryStream();
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
        Meta meta = widget.productsListBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          widget.productsListBloc.page.value = page;
          widget.productsListBloc..getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: widget.productsListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return CustomErrorWidget(snapshot.data.error);
          }
          return _buildProductListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return CustomErrorWidget(snapshot.error);
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

  Widget _buildProductListWidget(ProductResponse data) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    List<Product> products = data.products;
    return Scaffold(
      body: products.length > 0
          ? Container(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                  crossAxisCount: 4,
                  staggeredTileBuilder: isMobile
                      ? (int index) => StaggeredTile.fit(2)
                      : (int index) => StaggeredTile.fit(1),
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index], width: 200.0);
                  }))
          : Center(
              child: Text("No Products Found"),
            ),
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
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
                          "SORT BY",
                          // tr("SORT BY"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: _showSortProduct(context),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
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
            )
          ]),
    );
  }

  _showSortProduct(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text("SORT BY",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
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
                              widget.productsListBloc.sortBy.value == "default"
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                  onTap: () {
                    sortProducts(context, "default");
                  }),
              ListTile(
                  title: Text("Popularity",
                      style: TextStyle(
                          fontWeight: widget.productsListBloc.sortBy.value ==
                                  "popularity"
                              ? FontWeight.bold
                              : FontWeight.normal)),
                  onTap: () {
                    sortProducts(context, 'popularity');
                  }),
              ListTile(
                  title: Text("Low - High Price",
                      style: TextStyle(
                          fontWeight: widget.productsListBloc.sortBy.value ==
                                  "price_asc"
                              ? FontWeight.bold
                              : FontWeight.normal)),
                  onTap: () {
                    sortProducts(context, 'price_asc');
                  }),
              ListTile(
                  title: Text("High - Low Price",
                      style: TextStyle(
                          fontWeight: widget.productsListBloc.sortBy.value ==
                                  "price_desc"
                              ? FontWeight.bold
                              : FontWeight.normal)),
                  onTap: () {
                    sortProducts(context, 'price_desc');
                  }),
              ListTile(
                  title: Text("Average Rating",
                      style: TextStyle(
                          fontWeight: widget.productsListBloc.sortBy.value ==
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
    );
  }

  sortProducts(context, String sortBy) {
    widget.productsListBloc.subject.value = null;
    widget.productsListBloc.productResponse = null;
    widget.productsListBloc.sortBy.value = sortBy;
    widget.productsListBloc.getProducts();
    Navigator.of(context).pop();
  }

  void _showFilterProduct(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return FilterWidget(productsListBloc: widget.productsListBloc);
        });
  }
}
