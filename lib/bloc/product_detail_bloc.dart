import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
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

  getProductDetail(String slug) async {
    ProductDetailResponse response = await _repository.getProductDetail(slug);
//    this.selectedAttribute = this.product.attributes[0]
//    this.selectedImage = this.selectedAttribute.images[0].image_thumbnail
//    this.selectedVariant = this.selectedAttribute.variant
    _subject.sink.add(response);
  }

  getRelatedProduct(slug) async {
    ProductResponse response = await _repository.getRelatedProduct(slug);
    _related.sink.add(response);
  }

  getSameSellerProduct(slug) async {
    ProductResponse response = await _repository.getSameSellerProduct(slug);
    _fromSameSeller.sink.add(response);
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

final productDetailBloc = ProductDetailBloc();
