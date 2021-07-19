import 'package:rakurakubazzar/models/response/add_to_wishlist.dart';
import 'package:rakurakubazzar/models/response/product_detail_response.dart';
import 'package:rakurakubazzar/models/response/product_response.dart';
import 'package:rakurakubazzar/models/response/remove_from_wishlist.dart';
import 'package:rakurakubazzar/repository/repository.dart';
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

  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  ProductDetailResponse response;
  ProductResponse productResponse;

  getProductDetail(String slug) async {
    response = await _repository.getProductDetail(slug);
    _subject.sink.add(response);
    return response;
  }

  getRelatedProduct({slug, isCombo = false}) async {
    ProductResponse response =
        await _repository.getRelatedProduct(slug, isCombo);
    _related.sink.add(response);
  }

  // getSameSellerProduct({slug, isCombo = false}) async {
  //   ProductResponse response =
  //       await _repository.getSameSellerProduct(slug, isCombo);
  //   _fromSameSeller.sink.add(response);
  // }

  getSameSellerProduct({page, slug, isCombo}) async {
    _loading.sink.add(true);
    ProductResponse response = await _repository.getSameSellerProduct(page,slug,isCombo);

    if (response.error == null) {
      if (productResponse != null && productResponse.products.length > 0) {
        productResponse.products.addAll(response.products);
      } else {
        productResponse = response;
      }
    } else {
      productResponse = response;
    }

    _loading.sink.add(false);
    _fromSameSeller.sink.add(productResponse);
    // return orderResponse;
  }

  addToWishlist() async {
    var params = {
      "attribute_id": response.productDetail.selectedAttribute.id,
      "combo_id": null,
    };
    AddToWishlistResponse res = await _repository.addToWishlist(params);
    // response.productDetail.attributes.where((element) => element.id == params["attribute_id"]).saved = true;
    if (res.error == null) {
      response.productDetail.selectedAttribute.saved = true;
      _subject.sink.add(response);
    }
    return res;
  }

  deleteFromWishlist() async {
    var params = {
      "attribute_id": response.productDetail.selectedAttribute.id,
      "combo_id": null,
    };
    RemoveFromWishlistResponse res =
        await _repository.deleteFromWishlist(params);
    if (res.error == null) {
      response.productDetail.selectedAttribute.saved = false;
      _subject.sink.add(response);
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

  Stream<bool> get loading => _loading.stream;
}

//final productDetailBloc = ProductDetailBloc();
