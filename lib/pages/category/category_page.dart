import 'package:ecapp/bloc/get_products_byCategory_bloc.dart';
import 'package:ecapp/components/search_box.dart';
import 'package:ecapp/pages/category/components/filter_list.dart';
import 'package:ecapp/pages/category/components/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';
import '../main_page.dart';
import 'components/body.dart';
import 'package:ecapp/bloc/get_categories_bloc.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  ProductsListByCategoryBloc productsByCategoryBloc;

  Map<String, bool> values = {
    'featured': false,
    'best_sellers': false,
    'new_arrivals': false,
    'top_rated': false,
  };

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    productsByCategoryBloc = ProductsListByCategoryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text(
                    "FILTER",
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            onPressed: () {
              _showFilterProduct(context);
            },
          ),
        ),
      ]),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  MainPage.of(context).scaffoldKey.currentState.openDrawer();
                }
            ),
            SearchBox()
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CategoryBody(),
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
                            _sortProducts('default');
                          }),
                      ListTile(
                          title: Text("Popularity"),
                          onTap: () {
                            _sortProducts('popularity');
                          }),
                      ListTile(
                          title: Text("Low - High Price"),
                          onTap: () {
                            _sortProducts('price_asc');
                          }),
                      ListTile(
                          title: Text("High - Low Price"),
                          onTap: () {
                            _sortProducts('price_desc');
                          }),
                      ListTile(
                          title: Text("Average Rating"),
                          onTap: () {
                            _sortProducts('average_rating');
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showFilterProduct(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Filter Products',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  Column(
                    children: values.keys.map((String key) {
                      return new CheckboxListTile(
                        title: Text(key),
                        value: values[key],
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            values[key] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    controller: minController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Min"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: maxController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Max"),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () {
                        _filterProducts('sortBy', minController.text.trim(),
                            maxController.text.trim(), 'types');
                      },
                      child:
                          const Text('Filter', style: TextStyle(fontSize: 20)),
                      color: Colors.green,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _sortProducts(String sortBy) {
    const minPrice = '';
    const maxPrice = '';
    const types = '';

    ProductsByCategory().productsByCategoryBloc
      ..getCategoryProducts(
          ProductsByCategory().productsByCategoryBloc.category.value,
          sortBy,
          minPrice,
          maxPrice,
          types);
    Navigator.of(context).pop();
  }

  void _filterProducts(
      String sortBy, String minPrice, String maxPrice, String types) {
    productsByCategoryBloc
      ..getCategoryProducts(productsByCategoryBloc.category.value, sortBy,
          minPrice, maxPrice, types);
    Navigator.of(context).pop();
  }

  @override
  bool get wantKeepAlive => true;
}
