import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductDetailResponse> _subject =
      BehaviorSubject<ProductDetailResponse>();

  getProductDetail(int id) async {
    ProductDetailResponse response = await _repository.getProductDetail(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ProductDetailResponse> get subject => _subject;
  
}
final productDetailBloc = ProductDetailBloc();