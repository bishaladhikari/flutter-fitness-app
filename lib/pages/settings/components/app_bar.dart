import 'package:flutter/material.dart';

AppBar accountAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,

    elevation: 0,
//    leading: null,
//    leading: ImageButton(
//      image: SvgPicture.asset("assets/icons/menu.svg"),
//      onPressed: () {},
//    ),
    title: Text("Account Settings"),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ],
  );
}
