import 'dart:convert';

import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/cart_summary_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CartResponse> _subject =
      BehaviorSubject<CartResponse>();
  CartResponse response;

//  List<CartItem> _cartItems;

  List _products;

  getCart() async {
    response = await _repository.getCart();
    _subject.sink.add(response);
    if (response.error == null) {
      _products = List();
      response.carts.forEach((cart) {
        cart.items.forEach((item) {
          var product = {
            "attribute_id": item.attribute != null ? item.attribute.id : null,
            "combo_id": item.combo != null ? item.combo.id : null,
            "price":
                item.combo != null ? item.combo.price : item.attribute.price,
            "quantity": item.quantity,
            "store_id": 2
          };
          _products.add(product);
        });
      });
//       _cartItems = response.carts[0].items;
    }
    return response;
  }

//  get cartItems => _cartItems;
  get products => _products;

  addToCart(params) async {
    AddToCartResponse addToCartResponse = await _repository.addToCart(params);
    if (addToCartResponse.error == null) {
      response = await getCart();
//      response.totalItems += params['quantity'];
      _subject.sink.add(response);
    }

    return addToCartResponse;
  }

  updateCart(CartItem cartItem, type) async {
    response = await _repository.updateCart(cartItem, type);
    _subject.sink.add(response);
  }

  deleteFromCartList(id) async {
    response = await _repository.deleteFromCartList(id);
    if (response.error == null) _subject.sink.add(response);
    return response;
  }


  getCartSummary() async {
    CartSummaryResponse response = await _repository.getCartSummary();
    // _subject.sink.add(response);
    if(response.error == null){
      _subject.value.cartSummary = response.cartSummary;
    }
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CartResponse> get subject => _subject;
//  ValueStream<CartResponse> get cartList => _subject.stream;
}

final CartBloc cartBloc = CartBloc();
