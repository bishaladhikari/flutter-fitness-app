import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'address_bloc.dart';

class CheckoutBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddOrderResponse> _subject =
      BehaviorSubject<AddOrderResponse>();
  final BehaviorSubject<Address> _defaultAddress = BehaviorSubject<Address>();
  AddOrderResponse response;

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

  createOrder() async {
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
    var params = {
      "shipping_cost": 0,
      "weight": 4444,
      "address_id": 1,
      "store_id": 2,
//      "token": stripeToken,
      "redeemed_amount": "",
      "redeemed_points": "",
      "payment_method": "Cash Payment",
      "billable_amount": "4444",
//      "products": cartBloc.cartItems,
      "products": [
        {
          "attribute_id": 2,
          "combo_id": "",
          "price": "1111.00",
          "quantity": 4,
          "store_id": 2
        }
      ],
      "note": "",
      "achieved_promotions": [
        {"id": 1, "discount": 1000}
      ]
    };
    response = await _repository.createOrder(params);
    _subject.sink.add(response);
    return response;
  }

  getDefaultAddress() async {
    AddressResponse response = await addressBloc.getAddresses();
    if (response.error == null) _defaultAddress.sink.add(response.addresses[0]);
  }

  BehaviorSubject<AddOrderResponse> get addresses => _subject.stream;

  BehaviorSubject<Address> get defaultAddress => _defaultAddress.stream;
}

final CheckoutBloc checkoutBloc = CheckoutBloc();
