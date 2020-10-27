import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../main_page.dart';

AppBar AccountAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        MainPage.of(context).scaffoldKey.currentState.openDrawer();
      },
    ),
//    leading: null,
//    leading: ImageButton(
//      image: SvgPicture.asset("assets/icons/menu.svg"),
//      onPressed: () {},
//    ),
    title: Text("Profile"),
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).pushNamed('/settings-page');
        },
      )
    ],
  );
}
