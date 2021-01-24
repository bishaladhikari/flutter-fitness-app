import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/loyalty_point_bloc.dart';
import 'package:ecapp/bloc/order_product_detail_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'address_bloc.dart';

class CheckoutBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddOrderResponse> _subject =
      BehaviorSubject<AddOrderResponse>();

  // final BehaviorSubject<Address> _defaultAddress = BehaviorSubject<Address>();
  final BehaviorSubject<String> _paymentMethod = BehaviorSubject<String>();

  AddOrderResponse response;

//  loyalty point amount = total_amount-bulk_discount_amount
  void drainStream() {
    _subject.value = null;
    _paymentMethod.value = null;
    // _defaultAddress.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    // await _defaultAddress.drain();
    // _defaultAddress.close();
  }

  createOrder({context, token}) async {
    BuildContext dialogContext;
    showDialog(
        context: context,
        barrierColor: Colors.white70,
        barrierDismissible: false,
        builder: (context) {
          dialogContext = context;
          return Center(child: CircularProgressIndicator());
        });
    var addressId = addressBloc.defaultAddress.value.id;
    var cartSummary = cartBloc.subject.value.cartSummary;
    var shippingCost = cartSummary.shippingCost;
    var totalWeight = cartSummary.totalWeight;
    var cashOnDeliveryCharge = loyaltyPointBloc.cashOnDeliveryCharge;

//    var subTotal = cartBloc.subject.value.totalAmount;
//    var bulkDiscountCost = cartBloc.subject.value.bulkDiscountCost;
//    var redeemedAmount = loyaltyPointBloc.redeemResponse.value != null
//        ? loyaltyPointBloc.redeemResponse.value.amountValue
//        : 0;
//    var cashOnDeliveryCharge = loyaltyPointBloc.cashOnDeliveryCharge;
//    var shippingDiscountCost = cartBloc.subject.value.shippingDiscountCost;
//    var billableAmount = subTotal +
//        shippingCost -
//        bulkDiscountCost -
//        shippingDiscountCost -
//        redeemedAmount;

    var params = {
      "shipping_cost": shippingCost,
      "weight": totalWeight,
      "address_id": addressId,
//      "store_id": 2,
      "token": token,
      "redeemed_amount": "",
      "redeemed_points": "",
      "payment_method": paymentMethod.value,
      "billable_amount": billableAmount,
      "cash_on_delivery_charge": cashOnDeliveryCharge,
      "products": cartBloc.products,
      "note": "",
      "achieved_promotions": cartBloc.subject.value.achievedPromotions
          .map((e) => e.toJson())
          .toList()
    };
    response = await _repository.createOrder(params);
    Navigator.pop(dialogContext);
    _subject.sink.add(response);
    Fluttertoast.showToast(
        msg: response.error == null
            ? tr("Order Placed Successfully")
            : response.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: response.error == null ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.error == null) {
      checkoutBloc.drainStream();
      cartBloc.drainStream();
      Navigator.of(context).pushReplacementNamed(
        'orderConfirmationPage',
        // (r) => false,
        arguments: response.order,
      );
    }
//    if (response.error == null) {
//      Navigator.pop(context);
//      Navigator.of(context).pushNamed(
//          "orderConfirmationPage",
//          arguments: response.order);
//    } else {
//      Navigator.pop(context);
//      _scaffoldKey.currentState.showSnackBar(SnackBar(
//        content: Text(
//          tr(response.error),
//        ),
//        backgroundColor: Colors.redAccent,
//      ));
//    }
    return response;
  }

  getDefaultAddress() async {
    AddressResponse response = await addressBloc.getAddresses();
    // if (response.error == null) _defaultAddress.sink.add(response.addresses[0]);
  }

  // setDefaultAddress(address) {
  //   print("called default Address"+jsonEncode(address));
  //   _defaultAddress.sink.add(address);
  //   // _defaultAddress.value= address;
  // }

  BehaviorSubject<AddOrderResponse> get addresses => _subject.stream;

  // BehaviorSubject<Address> get defaultAddress => _defaultAddress.stream;

  get paymentMethod => _paymentMethod.stream;

  get totalAmount {
    var cartTotalAmount = cartBloc.subject.value.cartSummary.totalAmount;
    var bulkDiscountCost = cartBloc.subject.value.cartSummary.bulkDiscountCost;
    return cartTotalAmount - bulkDiscountCost;
  }

  get finalTotalAmount {
    var shippingCost = cartBloc.subject.value.cartSummary.shippingCost;
    var shippingDiscountCost =
        cartBloc.subject.value.cartSummary.shippingDiscountCost;
    return (totalAmount + shippingCost - shippingDiscountCost).round();
  }

  get billableAmount {
    var redeemedAmount =
        loyaltyPointBloc.redeemResponse.value?.amountValue ?? 0;
    var billableAmount = finalTotalAmount - redeemedAmount;
//    if (paymentMethod.value == "Cash Payment")
//      return billableAmount + cashOnDeliveryCharge;
    return billableAmount;
  }

  get payableTotal {
    print("paymentMethod"+paymentMethod.value.toString());
    if (paymentMethod.value == "Cash Payment")
      return (billableAmount + loyaltyPointBloc.cashOnDeliveryCharge).round();
    return billableAmount.round();
  }
}

final CheckoutBloc checkoutBloc = CheckoutBloc();
