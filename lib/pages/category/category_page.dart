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
              _sortProduct(context);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            cursorColor: Colors.grey,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/Cart_02.svg"),
            color: Colors.black,
            onPressed: () {},
          ),
          SizedBox(width: 20.0 / 2)
        ],
      ),
      body: CategoryBody(),
    );
  }

  void _sortProduct(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
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
                      ListTile(title: Text("What's New")),
                      ListTile(title: Text("Price - high to low")),
                      ListTile(title: Text("Popularity")),
                      ListTile(title: Text("Discount")),
                      ListTile(title: Text("Price - low to high")),
                      ListTile(title: Text('Customer Rating')),
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
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("SORT BY",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(title: Text("What's New")),
                      ListTile(title: Text("Price - high to low")),
                      ListTile(title: Text("Popularity")),
                      ListTile(title: Text("Discount")),
                      ListTile(title: Text("Price - low to high")),
                      ListTile(title: Text('Customer Rating')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10),
                        color: Color(0xfff29f39),
                        textColor: Colors.white,
                        child: Text("APPLY"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10),
                        color: Color(0xfff29f39),
                        textColor: Colors.white,
                        child: Text("CANCEL"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
