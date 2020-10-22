import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/combo_detail_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
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
      "attribute_id": response.comboDetail.selectedAttribute.id,
      "combo_id": null,
    };
    AddToWishlistResponse res = await _repository.addToWishlist(params);
    // response.productDetail.attributes.where((element) => element.id == params["attribute_id"]).saved = true;
    if (res.error == null) {
      var attributes = response.comboDetail.attributes;
      var index = attributes
          .indexWhere((element) => element.id == params["attribute_id"]);
      if (index > -1) response.comboDetail.attributes[index].saved = true;
    }
    return res;
  }

  deleteFromWishlist() async {
    var params = {
      "attribute_id": response.comboDetail.selectedAttribute.id,
      "combo_id": null,
    };
    RemoveFromWishlistResponse res =
        await _repository.deleteFromWishlist(params);
    if (res.error == null) {
      var attributes = response.comboDetail.attributes;
      var index = attributes
          .indexWhere((element) => element.id == params["attribute_id"]);
      if (index > -1) response.comboDetail.attributes[index].saved = false;
    }
    return res;
  }

  setSelectedAttribute(attribute) {
//    response.productDetail.selectedAttribute =
    response.comboDetail.selectedAttribute = attribute;
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

  BehaviorSubject<ComboDetailResponse> get subject => _subject;
}

//final productDetailBloc = ProductDetailBloc();
