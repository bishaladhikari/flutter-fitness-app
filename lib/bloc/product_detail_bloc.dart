import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
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

  setSelectedAttribute(attribute) {
//    response.productDetail.selectedAttribute =
    response.productDetail.selectedAttribute = attribute;
    _subject.sink.add(response);
  }

  void drainStream(slug) async {
    print(slug);
//    await _subject.where((event) => event.productDetail.slug==slug).s;
//    await _subject
//        .singleWhere((element) => element.productDetail.slug == slug)
//        .asStream()
//        .drain();
//    _subject.elementAt(index)
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
