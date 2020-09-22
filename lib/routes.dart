import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:ecapp/pages/wish/wishlistpage.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/wishListPage':
        return MaterialPageRoute(builder: (context) => WishListPage());
        break;
      case '/settings-page':
        return MaterialPageRoute(builder: (context) => SettingsPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
