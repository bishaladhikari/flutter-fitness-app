import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListByCategoryBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  getCategoryProducts(String category) async {
    ProductResponse response = await _repository.getCategoryProducts(category);
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

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productsByCategoryBloc = ProductsListByCategoryBloc();
