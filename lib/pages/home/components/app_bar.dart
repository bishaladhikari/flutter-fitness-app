import 'package:ecapp/components/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white.withOpacity(0),
    elevation: 0,
    title: SearchBox(),
    brightness: Brightness.dark,
//    leading: IconButton(
//      icon: Icon(Icons.menu),
//      onPressed: () {},
//    ),
//    title: RichText(
//      text: TextSpan(
//        style: Theme.of(context)
//            .textTheme
//            .title
//            .copyWith(fontWeight: FontWeight.bold),
//        children: [
//          TextSpan(
//            text: "Grocery",
//            style: TextStyle(color: ksecondaryColor),
//          ),
//          TextSpan(
//            text: "Store",
//            style: TextStyle(color: kPrimaryColor),
//          ),
//        ],
//      ),
//    ),
//    actions: <Widget>[
//      IconButton(
//        icon: SvgPicture.asset("assets/icons/notification.svg"),
//        onPressed: () {},
//      ),
//    ],
  );
}
