import 'package:ecapp/pages/address-book/address-form-page.dart';
import 'package:ecapp/pages/address-book/address-page.dart';
import 'package:ecapp/pages/auth/email-confirm%20.dart';
import 'package:ecapp/pages/auth/forget_password.dart';
import 'package:ecapp/pages/auth/login-page.dart';
import 'package:ecapp/pages/auth/register-page.dart';
import 'package:ecapp/pages/cart/cart-page.dart';
import 'package:ecapp/pages/product-details/product-detail-page.dart';
import 'package:ecapp/pages/search/search-page.dart';
import 'package:ecapp/pages/select_payment_method_page/select-payment-method-page.dart';
import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:ecapp/pages/wish/wishlistpage.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
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
      case 'cartPage':
        return MaterialPageRoute(builder: (context) => CartPage());
        break;
      case 'productDetailPage':
        return MaterialPageRoute(builder: (context) => ProductDetailPage(product: arguments,));
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
        case 'emailConfirmPage':
        return MaterialPageRoute(builder: (context) => EmailConfirmPage());
        break;
        case 'forgetpasswordPage':
        return MaterialPageRoute(builder: (context) => ForgetPasswordPage());
        break;
      case 'addressFormPage':
        return MaterialPageRoute(builder: (context) => AddressFormPage(address:arguments));
        break;
      case 'selectPaymentMethodPage':
        return MaterialPageRoute(builder: (context) => SelectPaymentMethodPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
