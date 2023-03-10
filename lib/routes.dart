import 'package:fitnessive/pages/webview-pages/webview-page.dart';
import 'package:fitnessive/pages/address-book/address-form-page.dart';
import 'package:fitnessive/pages/address-book/address-page.dart';
import 'package:fitnessive/pages/auth/email_confirm_page.dart';
import 'package:fitnessive/pages/auth/email-forgot-password-page.dart';
import 'package:fitnessive/pages/auth/forget_password.dart';
import 'package:fitnessive/pages/auth/login-page.dart';
import 'package:fitnessive/pages/auth/register-page.dart';
import 'package:fitnessive/pages/cart/cart-page.dart';
import 'package:fitnessive/pages/cash-on-delivery/cash-on-delivery-page.dart';
import 'package:fitnessive/pages/change-password/change_password_page.dart';
import 'package:fitnessive/pages/checkout/checkout-page.dart';
import 'package:fitnessive/pages/from-same-seller/from-same-seller-page.dart';
import 'package:fitnessive/pages/home/components/discount-view.dart';
import 'package:fitnessive/pages/main_page.dart';
import 'package:fitnessive/pages/no-internet/no-internet-page.dart';
import 'package:fitnessive/pages/order-complete/order-complete-page.dart';
import 'package:fitnessive/pages/order_review/order_review_page.dart';
import 'package:fitnessive/pages/privacy/privacy-page.dart';
import 'package:fitnessive/pages/rating-reviews/ratings-reviews-page.dart';
import 'package:fitnessive/pages/search/search-page.dart';
import 'package:fitnessive/pages/settings/settings-page.dart';
import 'package:fitnessive/pages/wish/wishlistpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

abstract class Routes {
  static PageTransition materialPageRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
//    final arguments = routeSettings.arguments as Map<String, dynamic> ?? {};
    switch (routeSettings.name) {
      case 'mainPage':
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: MainPage());
        break;
      case 'noInternetPage':
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: NoInternetPage());
        break;
      case 'privacyPage':
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: PrivacyPage());
        break;
//       case 'discountView':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: DiscountView(discountInfo: arguments));
//         break;
//       case 'storePage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: StorePage(storeSlug: arguments));
//         break;
//       case 'wishListPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: WishListPage());
//         break;
//       case '/settings-page':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: SettingsPage());
//         break;
      case 'loginPage':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: LoginPage());
        break;
//       case 'cartPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: CartPage());
//         break;
//       case 'productDetailPage':
//         return PageTransition(
//             type: PageTransitionType.fade,
//             child: ProductDetailPage(
//               product: arguments,
//             ));
//         break;
//       case 'comboDetailPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: ComboDetailPage(
//               combo: arguments,
//             ));
//         break;
//       case 'registerPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: RegisterPage());
//         break;
//       case 'searchPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: SearchPage());
//         break;
//       case 'addressPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: AddressPage(selectMode: arguments));
//         break;
//       case 'emailConfirmPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: EmailConfirmPage(email: arguments));
//         break;
//       case 'forgetPasswordPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: ForgetPasswordPage(email: arguments));
//         break;
//       case 'emailForgotPasswordPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: EmailForgotPasswordPage());
//         break;
//       case 'addressFormPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: AddressFormPage(address: arguments));
//         break;
//       case 'ordersPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: OrdersListPage());
//         break;
//       case 'selectPaymentMethodPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: SelectPaymentMethodPage());
//         break;
//       case 'checkoutPage':
// //        return PageTransition(type:PageTransitionType.rightToLeft,child:  CheckoutPage());
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: CheckoutPage());
//         break;
//       case 'cashOnDeliveryPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: CashOnDeliveryPage());
//         break;
//       case 'ordersPages':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: OrdersListPage());
//         break;
//       case 'orderDetailPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: OrderDetailPage(order: arguments));
//         break;
//       case 'orderConfirmationPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: OrderCompletePage(order: arguments));
//         break;
//       case 'orderReviewPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: OrderReviewPage(orderProductItem: arguments));
//         break;
//       case 'ratingsReviewsPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: RatingsReviewsPage(productDetail: arguments));
//         break;
//       case 'fromSameSellerPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: FromSameSellerPage(slug: arguments));
//         break;
//       case 'productViewMore':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: ProductViewMorePage(types: arguments));
//         break;
//       case 'accountInformationPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: AccountInformationPage());
//         break;
//       case 'userPasswordForm':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft, child: ChangePasswordPage());
//         break;
//       case 'webViewPage':
//         return PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: WebViewPage(infoPage: arguments));
        break;
      default:
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: WishListPage());
    }
  }
}
