import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/pages/address-book/address-form-page.dart';
import 'package:ecapp/pages/address-book/address-page.dart';
import 'package:ecapp/pages/auth/email-confirm.dart';
import 'package:ecapp/pages/auth/forget_password.dart';
import 'package:ecapp/pages/auth/login-page.dart';
import 'package:ecapp/pages/auth/register-page.dart';
import 'package:ecapp/pages/card-payment/card-payment-page.dart';
import 'package:ecapp/pages/cart/cart-page.dart';
import 'package:ecapp/pages/cash-on-delivery/cash-on-delivery-page.dart';
import 'package:ecapp/pages/checkout/checkout-page.dart';
import 'package:ecapp/pages/order-confirmation/order-confirmation-page.dart';
import 'package:ecapp/pages/order-details/order-detail-page.dart';
import 'package:ecapp/pages/order_review/order_review_page.dart';
import 'package:ecapp/pages/product-details/product-detail-page.dart';
import 'package:ecapp/pages/search/search-page.dart';
import 'package:ecapp/pages/select_payment_method/select-payment-method-page.dart';
import 'package:ecapp/pages/settings/settings-page.dart';
import 'package:ecapp/pages/wish/wishlistpage.dart';
import 'package:ecapp/pages/orders/orders_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
//    final arguments = settings.arguments as Map<String, dynamic> ?? {};
    switch (routeSettings.name) {
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
        return MaterialPageRoute(builder: (context) => OrderConfirmationPage());
        break;
      case 'orderReviewPage':
        return MaterialPageRoute(builder: (context) => OrderReviewPage(orderProduct: arguments));
        break;
      default:
        return MaterialPageRoute(builder: (context) => WishListPage());
    }
  }
}
