import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

AppBar AccountAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.deepOrangeAccent,
    elevation: 0,
//    leading: null,
//    leading: ImageButton(
//      image: SvgPicture.asset("assets/icons/menu.svg"),
//      onPressed: () {},
//    ),
    title: Text(""),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
    ],
  );
}
