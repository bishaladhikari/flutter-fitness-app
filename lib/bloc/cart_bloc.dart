import 'package:dio/dio.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/wish.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CartResponse> _subject =
      BehaviorSubject<CartResponse>();
  CartResponse response;
  List<CartItem> _cartItems;

  getCart() async {
    response = await _repository.getCart();
    _subject.sink.add(response);
    if (response.error != null) _cartItems = response.carts[0].items;
  }

  get cartItems => _cartItems;

  addToCart(params) async {
    AddToCartResponse response = await _repository.addToCart(params);
    return response;
  }

  updateCart(CartItem cartItem, type) async {
    response = await _repository.updateCart(cartItem, type);
    _subject.sink.add(response);
  }

  deleteFromCartList(id) async {
    await _repository.deleteWishlist(id);
    response.deleteFromCarts(id);
    _subject.sink.add(response);

    print("response:" + response.toString());
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
