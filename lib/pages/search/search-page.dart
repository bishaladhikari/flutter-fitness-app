import 'package:ecapp/pages/main_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List cat = [
    'Food','Male Fashion','Female Fashion'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(50, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Here",
//                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Row(children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, color: Colors.white),
                    ),
                  ]))
            ],
          )),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    ));
  }
}
