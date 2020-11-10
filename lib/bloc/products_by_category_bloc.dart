import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListByCategoryBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  final BehaviorSubject<String> _category = BehaviorSubject<String>();

  getCategoryProducts(String category, String sortBy, String minPrice,
      String maxPrice, String types) async {
    ProductResponse response = await _repository.getCategoryProducts(
        category, sortBy, minPrice, maxPrice, types);
    _subject.sink.add(response);
//    categoryBloc.selectedCategory = category;
    _category.sink.add(category);
  }
//  getBrands(){
//    brandsBloc.getBrands(category: _category.value);
//  }

  void drainStream() {
    _subject.value = null;
  }
  void drainCategoryStream(){
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

  BehaviorSubject<String> get category => _category;
}

final productsByCategoryBloc = ProductsListByCategoryBloc();
