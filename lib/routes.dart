import 'package:ecapp/pages/address-book/address-form-page.dart';
import 'package:ecapp/pages/address-book/address-page.dart';
import 'package:ecapp/pages/auth/email-confirm.dart';
import 'package:ecapp/pages/auth/email-forgot-password-page.dart';
import 'package:ecapp/pages/auth/forget_password.dart';
import 'package:ecapp/pages/auth/login-page.dart';
import 'package:ecapp/pages/auth/register-page.dart';
import 'package:ecapp/pages/card-payment/card-payment-page.dart';
import 'package:ecapp/pages/cart/cart-page.dart';
import 'package:ecapp/pages/cash-on-delivery/cash-on-delivery-page.dart';
import 'package:ecapp/pages/checkout/checkout-page.dart';
import 'package:ecapp/pages/combo/combo-detail-page.dart';
import 'package:ecapp/pages/main_page.dart';
import 'package:ecapp/pages/order-complete/order-complete-page.dart';
import 'package:ecapp/pages/order-details/order-detail-page.dart';
import 'package:ecapp/pages/order_review/order_review_page.dart';
import 'package:ecapp/pages/privacy/privacy-page.dart';
import 'package:ecapp/pages/product-details/product-detail-page.dart';
import 'package:ecapp/pages/search/search-page.dart';
import 'package:ecapp/pages/select_payment_method/select-payment-method-page.dart';
import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:ecapp/pages/store/store-page.dart';
import 'package:ecapp/pages/wish/wishlistpage.dart';
import 'package:ecapp/pages/orders/orders_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
//    final arguments = routeSettings.arguments as Map<String, dynamic> ?? {};
    switch (routeSettings.name) {
      case 'mainPage':
        return MaterialPageRoute(builder: (context) => MainPage());
        break;
      case 'privacyPage':
        return MaterialPageRoute(builder: (context) => PrivacyPage());
        break;
      case 'storePage':
        return MaterialPageRoute(builder: (context) => StorePage());
        break;
      case 'wishListPage':
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
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                  product: arguments,
                ));
        break;
      case 'comboDetailPage':
        return MaterialPageRoute(
            builder: (context) => ComboDetailPage(
                  combo: arguments,
                ));
        break;
      case 'registerPage':
        return MaterialPageRoute(builder: (context) => RegisterPage());
        break;
      case 'searchPage':
        return MaterialPageRoute(builder: (context) => SearchPage());
        break;
      case 'addressPage':
        return MaterialPageRoute(
            builder: (context) => AddressPage(selectMode: arguments));
        break;
      case 'emailConfirmPage':
        return MaterialPageRoute(
            builder: (context) => EmailConfirmPage(email: arguments));
        break;
      case 'forgetPasswordPage':
        return MaterialPageRoute(
            builder: (context) => ForgetPasswordPage(email: arguments));
        break;
      case 'emailForgotPasswordPage':
        return MaterialPageRoute(
            builder: (context) => EmailForgotPasswordPage());
        break;
      case 'addressFormPage':
        return MaterialPageRoute(
            builder: (context) => AddressFormPage(address: arguments));
        break;
      case 'ordersPage':
        return MaterialPageRoute(builder: (context) => OrdersListPage());
        break;
      case 'selectPaymentMethodPage':
        return MaterialPageRoute(
            builder: (context) => SelectPaymentMethodPage());
        break;
      case 'checkoutPage':
        return MaterialPageRoute(builder: (context) => CheckoutPage());
        break;
      case 'cashOnDeliveryPage':
        return MaterialPageRoute(builder: (context) => CashOnDeliveryPage());
        break;
      case 'cardPaymentPage':
        return MaterialPageRoute(builder: (context) => CardPaymentPage());
      case 'ordersPages':
        return MaterialPageRoute(builder: (context) => OrdersListPage());
        break;
      case 'orderDetailPage':
        return MaterialPageRoute(
            builder: (context) => OrderDetailPage(order: arguments));
        break;
      case 'orderConfirmationPage':
        return MaterialPageRoute(
            builder: (context) => OrderCompletePage(order: arguments));
        break;
      case 'orderReviewPage':
        return MaterialPageRoute(
            builder: (context) => OrderReviewPage(orderProductItem: arguments));
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
