import 'package:ecapp/bloc/get_products_byCategory_bloc.dart';
import 'package:ecapp/components/search_box.dart';
import 'package:ecapp/pages/category/components/filter_list.dart';
import 'package:ecapp/pages/category/components/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';
import 'package:ecapp/bloc/get_categories_bloc.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  ProductsListByCategoryBloc productsByCategoryBloc;
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
              _filterProduct(context);
            },
          ),
        ),
      ]),
      appBar: AppBar(backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBox(),
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

  void _filterProduct(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[FilterList()],
              ),
            ),
          );
        });
  }

  void _sortProducts(String sortBy) {
    productsByCategoryBloc
      ..getCategoryProducts(productsByCategoryBloc.category.value, sortBy);
    Navigator.of(context).pop();
  }

  @override
  bool get wantKeepAlive => true;
}
