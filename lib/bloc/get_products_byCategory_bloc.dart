import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListByCategoryBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  final BehaviorSubject<String> _category =
  BehaviorSubject<String>();

  getCategoryProducts(String category, String sortBy) async {
    ProductResponse response =
        await _repository.getCategoryProducts(category, sortBy);
    _subject.sink.add(response);
    _category.sink.add(category);
  }

  void drainStream() {
    _subject.value = null;
    _category.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _category.drain();
    _category.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productsByCategoryBloc = ProductsListByCategoryBloc();
