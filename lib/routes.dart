import 'package:ecapp/pages/address-book/address-form-page.dart';
import 'package:ecapp/pages/address-book/address-page.dart';
import 'package:ecapp/pages/auth/login-page.dart';
import 'package:ecapp/pages/auth/register-page.dart';
import 'package:ecapp/pages/search/search-page.dart';
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
      case 'loginPage':
        return MaterialPageRoute(builder: (context) => LoginPage());
        break;
      case 'registerPage':
        return MaterialPageRoute(builder: (context) => RegisterPage());
        break;
      case 'searchPage':
        return MaterialPageRoute(builder: (context) => SearchPage());
        break;
      case 'addressPage':
        return MaterialPageRoute(builder: (context) => AddressPage());
        break;
      case 'addressFormPage':
        return MaterialPageRoute(builder: (context) => AddressFormPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
