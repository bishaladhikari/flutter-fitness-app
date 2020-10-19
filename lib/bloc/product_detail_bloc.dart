import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductDetailResponse> _subject =
      BehaviorSubject<ProductDetailResponse>();
  final BehaviorSubject<ProductResponse> _related =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _fromSameSeller =
      BehaviorSubject<ProductResponse>();
  ProductDetailResponse response;

  getProductDetail(String slug) async {
    response = await _repository.getProductDetail(slug);
    _subject.sink.add(response);
    return response;
  }

  getRelatedProduct(slug) async {
    ProductResponse response = await _repository.getRelatedProduct(slug);
    _related.sink.add(response);
  }

  getSameSellerProduct(slug) async {
    ProductResponse response = await _repository.getSameSellerProduct(slug);
    _fromSameSeller.sink.add(response);
  }

  addToWishlist(params) async {
    AddToWishlistResponse res = await _repository.addToWishlist(params);
    // response.productDetail.attributes.where((element) => element.id == params["attribute_id"]).saved = true;
    if (res.error == null) {
      var attributes = response.productDetail.attributes;
      var index = attributes
          .indexWhere((element) => element.id == params["attribute_id"]);
      if (index > -1) response.productDetail.attributes[index].saved = true;
    }
    return res;
  }

  deleteFromWishlist(params) async {
    RemoveFromWishlistResponse res = await _repository.deleteFromWishlist(params);
    if (res.error == null) {
      var attributes = response.productDetail.attributes;
      var index = attributes
          .indexWhere((element) => element.id == params["attribute_id"]);
      if (index > -1) response.productDetail.attributes[index].saved = false;
    }
    return res;
  }

  setSelectedAttribute(attribute) {
//    response.productDetail.selectedAttribute =
    response.productDetail.selectedAttribute = attribute;
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
    _related.value = null;
    _fromSameSeller.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    _related.close();
    _fromSameSeller.close();
  }

  BehaviorSubject<ProductDetailResponse> get subject => _subject;

  BehaviorSubject<ProductResponse> get related => _related;

  BehaviorSubject<ProductResponse> get fromSameSeller => _fromSameSeller;
}

//final productDetailBloc = ProductDetailBloc();
