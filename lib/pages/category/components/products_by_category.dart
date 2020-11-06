import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/bloc/products_by_category_bloc.dart';
import 'package:ecapp/components/filter_widget.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsByCategory extends StatefulWidget {
  final String category;
  final String sortBy;
  final String minPrice;
  final String maxPrice;
  final String types;

  ProductsListByCategoryBloc productsByCategoryBloc;

  ProductsByCategory(
      {Key key,
//      this.productsByCategoryBloc,
      this.category,
      this.sortBy,
      this.minPrice,
      this.maxPrice,
      this.types}) {
    productsByCategoryBloc = ProductsListByCategoryBloc();
//    categoryBloc.productsByCategoryBloc = _productsByCategoryBloc;
//    super(key: key);
  }

  @override
  _ProductsByCategoryState createState() =>
      _ProductsByCategoryState(category, sortBy, minPrice, maxPrice, types);

  static _ProductsByCategoryState of(BuildContext context) {
    final _ProductsByCategoryState navigator = context
        // ignore: deprecated_member_use
        .ancestorStateOfType(const TypeMatcher<_ProductsByCategoryState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a ProductsByCategory.');
      }
      return true;
    }());

    return navigator;
  }
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final String category;
  final String sortBy;
  final String minPrice;
  final String maxPrice;
  final String types;
  String sort_type = "default";

//  ProductsListByCategoryBloc productsByCategoryBloc;

  _ProductsByCategoryState(
      this.category, this.sortBy, this.minPrice, this.maxPrice, this.types);

  @override
  void initState() {
    super.initState();
    widget.productsByCategoryBloc
      ..getCategoryProducts(category, sortBy, minPrice, maxPrice, types);
    brandsBloc.getBrands(category: category);
  }

  @override
  void dispose() {
    super.dispose();
    widget.productsByCategoryBloc.drainStream();
    widget.productsByCategoryBloc.drainCategoryStream();
    brandsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: widget.productsByCategoryBloc.subject.stream,
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
      body: Container(
          padding: EdgeInsets.only(top: 18),
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(product: products[index], width: 200.0);
              })),
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
                                  fontWeight: sort_type == "default"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, "default");
                          }),
                      ListTile(
                          title: Text("Popularity",
                              style: TextStyle(
                                  fontWeight: sort_type == "popularity"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'popularity');
                          }),
                      ListTile(
                          title: Text("Low - High Price",
                              style: TextStyle(
                                  fontWeight: sort_type == "price_asc"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'price_asc');
                          }),
                      ListTile(
                          title: Text("High - Low Price",
                              style: TextStyle(
                                  fontWeight: sort_type == "price_desc"
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                          onTap: () {
                            sortProducts(context, 'price_desc');
                          }),
                      ListTile(
                          title: Text("Average Rating",
                              style: TextStyle(
                                  fontWeight: sort_type == "average_rating"
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
    widget.productsByCategoryBloc.drainStream();
    const minPrice = '';
    const maxPrice = '';
    const types = '';
    setState(() {
      sort_type = sortBy;
    });
    widget.productsByCategoryBloc.getCategoryProducts(
        widget.productsByCategoryBloc.category.value,
        sortBy,
        minPrice,
        maxPrice,
        types);
    Navigator.of(context).pop();
  }

  void _showFilterProduct(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return FilterWidget();
        });
  }
}
