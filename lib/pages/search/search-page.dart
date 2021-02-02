import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List cat = ['Food', 'Male Fashion', 'Female Fashion'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      title: TextField(
        autofocus: true,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {},
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          border: InputBorder.none,
//          icon: SvgPicture.asset("assets/icons/search.svg"),
//          icon:  IconButton(
//      icon: Icon(Icons.menu),
//            onPressed: () {},
//          ),
          hintText: tr("Search Here"),
          hintStyle: TextStyle(color: ksecondaryColor),
        ),
      ),
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
