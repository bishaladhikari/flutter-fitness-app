import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddOrderResponse> _subject =
      BehaviorSubject<AddOrderResponse>();
  AddOrderResponse response;

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
//      "token": stripeToken,
      "redeemed_amount": "",
      "redeemed_points": "",
      "payment_method": "Cash Payment",
      "billable_amount": "4444",
      "products": cartItems,
      "note": "",
      "achieved_promotions": []
    };
    response = await _repository.createOrder(params);
    _subject.sink.add(response);
    return response;
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<AddressResponse> get addresses => _subject.stream;
}

final CheckoutBloc checkoutBloc = CheckoutBloc();
