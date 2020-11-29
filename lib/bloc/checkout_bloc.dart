import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/loyalty_point_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/address_response.dart';
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
  final BehaviorSubject<Address> _defaultAddress = BehaviorSubject<Address>();
  final BehaviorSubject<String> _paymentMethod = BehaviorSubject<String>();

  AddOrderResponse response;

//  loyalty point amount = total_amount-bulk_discount_amount
  void drainStream() {
    _subject.value = null;
    _defaultAddress.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _defaultAddress.drain();
    _defaultAddress.close();
  }

  createOrder({context, token}) async {
    showDialog(
        context: context,
        barrierColor: Colors.white70,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
//                  achieved_promotions: []
//                  address_id: 1
//                  billable_amount: "4444.00"
//                  note: ""
//                  payment_method: "Cash Payment"
//                  products: [{attribute_id: 2, combo_id: "", price: "1111.00", quantity: 4, store_id: 2}]
//                  0: {attribute_id: 2, combo_id: "", price: "1111.00", quantity: 4, store_id: 2}
//                  attribute_id: 2
//                  combo_id: ""
//                  price: "1111.00"
//                  quantity: 4
//                  store_id: 2
//                  redeemed_amount: ""
//                  redeemed_points: ""
//                  shipping_cost: 0
//                  weight: 4444
    var addressId = _defaultAddress.value.id;
    var shippingCost = cartBloc.subject.value.shippingCost;
    var totalWeight = cartBloc.subject.value.totalWeight;

    var subTotal = cartBloc.subject.value.totalAmount;
    var bulkDiscountCost = cartBloc.subject.value.bulkDiscountCost;
    var redeemedAmount = loyaltyPointBloc.redeemResponse.value != null
        ? loyaltyPointBloc.redeemResponse.value.amountValue
        : 0;
    var cashOnDeliveryCharge = loyaltyPointBloc.cashOnDeliveryCharge;
    var shippingDiscountCost = cartBloc.subject.value.shippingDiscountCost;
    var billableAmount = subTotal +
        shippingCost -
        bulkDiscountCost -
        shippingDiscountCost -
        redeemedAmount;

    var params = {
      "shipping_cost": shippingCost,
      "weight": totalWeight,
      "address_id": addressId,
//      "store_id": 2,
      "token": token,
      "redeemed_amount": "",
      "redeemed_points": "",
      "payment_method": paymentMethod.value,
      "billable_amount": paymentMethod.value == "Cash Payment"
          ? billableAmount + cashOnDeliveryCharge
          : billableAmount,
      "products": cartBloc.products,
      "note": "",
      "achieved_promotions": cartBloc.subject.value.achievedPromotions
    };
    response = await _repository.createOrder(params);
    _subject.sink.add(response);
    if (response.error == null) cartBloc.response = null;
    Fluttertoast.showToast(
        msg: response.error == null ? tr("Order Placed Successfully") : response.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: response.error == null ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.error == null) {
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed('orderConfirmationPage');
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
    if (response.error == null) _defaultAddress.sink.add(response.addresses[0]);
  }

  setDefaultAddress(address) {
    _defaultAddress.sink.add(address);
  }

  BehaviorSubject<AddOrderResponse> get addresses => _subject.stream;

  BehaviorSubject<Address> get defaultAddress => _defaultAddress.stream;

  get paymentMethod => _paymentMethod.stream;
//  get billableAmount => billableAmount;
}

final CheckoutBloc checkoutBloc = CheckoutBloc();
