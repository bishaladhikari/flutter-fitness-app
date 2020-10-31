import 'package:ecapp/bloc/categories_bloc.dart';
import 'package:ecapp/bloc/products_by_category_bloc.dart';
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

//  ProductsListByCategoryBloc productsByCategoryBloc;

  _ProductsByCategoryState(
      this.category, this.sortBy, this.minPrice, this.maxPrice, this.types);

  @override
  void initState() {
    super.initState();
    widget.productsByCategoryBloc
      ..getCategoryProducts(category, sortBy, minPrice, maxPrice, types);
  }

  @override
  void dispose() {
    super.dispose();
    widget.productsByCategoryBloc..drainStream();
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
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
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
                    "SORT BY",
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
//              _showFilterProduct(context);
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
                          title: Text("Default"),
                          onTap: () {
                            sortProducts(context, 'default');
                          }),
                      ListTile(
                          title: Text("Popularity"),
                          onTap: () {
                            sortProducts(context, 'popularity');
                          }),
                      ListTile(
                          title: Text("Low - High Price"),
                          onTap: () {
                            sortProducts(context, 'price_asc');
                          }),
                      ListTile(
                          title: Text("High - Low Price"),
                          onTap: () {
                            sortProducts(context, 'price_desc');
                          }),
                      ListTile(
                          title: Text("Average Rating"),
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
    const minPrice = '';
    const maxPrice = '';
    const types = '';
    widget.productsByCategoryBloc.getCategoryProducts(
        widget.productsByCategoryBloc.category.value,
        sortBy,
        minPrice,
        maxPrice,
        types);
    Navigator.of(context).pop();
  }

//  void _showFilterProduct(context) {
//    showModalBottomSheet(
//        isScrollControlled: true,
//        context: context,
//        builder: (BuildContext bc) {
//          return Container(
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                children: <Widget>[
//                  Text(
//                    'Filter Products',
//                    textAlign: TextAlign.center,
//                    overflow: TextOverflow.ellipsis,
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black,
//                        fontSize: 20),
//                  ),
//                  Column(
//                    children: values.keys.map((String key) {
//                      return new CheckboxListTile(
//                        title: Text(key),
//                        value: values[key],
//                        onChanged: (bool value) {
//                          print(value);
//                          setState(() {
//                            values[key] = value;
//                          });
//                        },
//                      );
//                    }).toList(),
//                  ),
//                  TextFormField(
//                    controller: minController,
//                    style: TextStyle(color: Color(0xFF000000)),
//                    cursorColor: Color(0xFF9b9b9b),
//                    keyboardType: TextInputType.text,
//                    decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        contentPadding: new EdgeInsets.symmetric(
//                            vertical: 10.0, horizontal: 10.0),
//                        hintStyle: TextStyle(color: Colors.grey),
//                        hintText: "Min"),
//                  ),
//                  SizedBox(height: 10),
//                  TextFormField(
//                    controller: maxController,
//                    style: TextStyle(color: Color(0xFF000000)),
//                    cursorColor: Color(0xFF9b9b9b),
//                    keyboardType: TextInputType.text,
//                    decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        contentPadding: new EdgeInsets.symmetric(
//                            vertical: 10.0, horizontal: 10.0),
//                        hintStyle: TextStyle(color: Colors.grey),
//                        hintText: "Max"),
//                  ),
//                  Container(
//                    alignment: Alignment.bottomCenter,
//                    child: RaisedButton(
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(18.0),
//                          side: BorderSide(color: Colors.green)),
//                      onPressed: () {
//                        _filterProducts('sortBy', minController.text.trim(),
//                            maxController.text.trim(), 'types');
//                      },
//                      child:
//                      const Text('Filter', style: TextStyle(fontSize: 20)),
//                      color: Colors.green,
//                      textColor: Colors.white,
//                      elevation: 5,
//                    ),
//                  )
//                ],
//              ),
//            ),
//          );
//        });
//  }
}
