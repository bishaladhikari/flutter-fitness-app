import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListByCategoryBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<List<String>> _brands = BehaviorSubject<List<String>>();

  final BehaviorSubject<String> _category = BehaviorSubject<String>();

  ProductsListByCategoryBloc() {
    _brands.value = [];
  }

  getCategoryProducts(
      {String category,
      String sortBy,
      String minPrice,
      String maxPrice,
      String types,
      String brands}) async {
    ProductResponse response = await _repository.getCategoryProducts(
        category:category,
        sortBy: sortBy,
        minPrice: minPrice,
        maxPrice: maxPrice,
        types: types,
        brands: brands);
    _subject.sink.add(response);
//    categoryBloc.selectedCategory = category;
    _category.sink.add(category);
  }

//  getBrands(){
//    brandsBloc.getBrands(category: _category.value);
//  }

  void drainStream() {
    _subject.value = null;
    _brands.value = [];
  }

  void drainCategoryStream() {
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

  BehaviorSubject<List<String>> get brands => _brands;

//  set addBrands(brand) => _brands.add(brand);
}

final productsByCategoryBloc = ProductsListByCategoryBloc();
