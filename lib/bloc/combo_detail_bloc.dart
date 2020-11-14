import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/combo_detail_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ComboDetailBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ComboDetailResponse> _subject =
      BehaviorSubject<ComboDetailResponse>();

  ComboDetailResponse response;

  getComboDetail(String slug) async {
    response = await _repository.getComboDetail(slug);
    _subject.sink.add(response);
    return response;
  }

  addToWishlist() async {
    var params = {
      "attribute_id": null,
      "combo_id": response.comboDetail.id,
    };
    AddToWishlistResponse res = await _repository.addToWishlist(params);
    // response.productDetail.attributes.where((element) => element.id == params["attribute_id"]).saved = true;
    if (res.error == null) {
      response.comboDetail.saved = true;
      _subject.sink.add(response);
    }
    return res;
  }

  deleteFromWishlist() async {
    var params = {
      "attribute_id": null,
      "combo_id": response.comboDetail.id,
    };
    RemoveFromWishlistResponse res =
    await _repository.deleteFromWishlist(params);
    if (res.error == null) {
      response.comboDetail.saved = false;
      _subject.sink.add(response);
    }
    return res;
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ComboDetailResponse> get subject => _subject;
}
