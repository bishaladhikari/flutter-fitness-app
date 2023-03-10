import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
    title: Text(tr("Profile")),
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
