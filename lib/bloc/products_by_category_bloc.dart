import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListByCategoryBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<List<String>> _brandFilters = BehaviorSubject<List<String>>();
  final BehaviorSubject<List<String>> _categoryFilters = BehaviorSubject<List<String>>();

  final BehaviorSubject<String> _currentCategory = BehaviorSubject<String>();

  ProductsListByCategoryBloc() {
    _brandFilters.value = [];
    _categoryFilters.value = [];
//    _categoryFilters.value.add(_currentCategory.value);
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
    _currentCategory.sink.add(category);
  }

//  getBrands(){
//    brandsBloc.getBrands(category: _category.value);
//  }

  void drainStream() {
    _subject.value = null;
    _brandFilters.value = [];
    _categoryFilters.value = [];
  }

  void drainCategoryStream() {
    _currentCategory.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _currentCategory.drain();
    _currentCategory.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;

  BehaviorSubject<String> get currentCategory => _currentCategory;

  BehaviorSubject<List<String>> get brandFilters => _brandFilters;
  BehaviorSubject<List<String>> get categoryFilters => _categoryFilters;

//  set addBrands(brand) => _brands.add(brand);
}

final productsByCategoryBloc = ProductsListByCategoryBloc();
