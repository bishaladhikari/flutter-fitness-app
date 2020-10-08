import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/cart_item.dart';
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

  getCart() async {
    response = await _repository.getCart();
    _subject.sink.add(response);
    print("response:" + response.totalAmount.toString());

  }

  updateCart(CartItem cartItem) async {
    response = await _repository.updateCart(cartItem);
    _subject.sink.add(response);
    print("response:" + response.totalAmount.toString());

  }

  deleteFromCartList(id) async {
    await _repository.deleteWishlist(id);
    response.deleteFromCarts(id);
    _subject.sink.add(response);

    print("response:" + response.toString());
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CartResponse> get subject => _subject;
//  ValueStream<CartResponse> get cartList => _subject.stream;
}

final CartBloc cartBloc = CartBloc();
