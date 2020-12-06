import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class WishListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<WishlistResponse> _subject =
      BehaviorSubject<WishlistResponse>();
  WishlistResponse response;

  getWishlist() async {
    response = await _repository.getWishlist();
    _subject.sink.add(response);
  }

  addToWishList(params) async {
    AddToWishlistResponse res = await _repository.addToWishlist(params);
    // response.productDetail.attributes.where((element) => element.id == params["attribute_id"]).saved = true;
    if (res.error == null) {
      _subject.sink.add(response);
    }
    return res;
  }

  removeFromWishList(params) async {
    RemoveFromWishlistResponse res = await _repository.deleteFromWishlist(params);
    if (res.error == null) {
      // response.productDetail.selectedAttribute.saved = false;
      _subject.sink.add(response);
    }
    return res;
  }

  deleteFromWishList(id) async {
    await _repository.deleteWishlist(id);
    response.deleteFromWishList(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<WishlistResponse> get subject => _subject;
//  Stream<WishlistResponse> get subject => _subject.stream;
}

final WishListBloc wishListBloc = WishListBloc();
