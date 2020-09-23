import 'package:ecapp/pages/wish/wishlistpage.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/wishListPage':
        return MaterialPageRoute(builder: (context) => WishListPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
