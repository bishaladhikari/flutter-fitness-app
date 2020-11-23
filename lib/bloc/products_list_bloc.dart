// import 'dart:js';
// import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/models/brand.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<List<Brand>> _brandFilters =
      BehaviorSubject<List<Brand>>();
  final BehaviorSubject<List<Category>> _categoryFilters =
      BehaviorSubject<List<Category>>();
  final BehaviorSubject<String> _searchTerm =
  BehaviorSubject<String>();

  final BehaviorSubject<String> _currentCategory = BehaviorSubject<String>();
  final BehaviorSubject<String> _minRange = BehaviorSubject<String>();
  final BehaviorSubject<String> _maxRange = BehaviorSubject<String>();
  final BehaviorSubject<String> _sortBy = BehaviorSubject<String>();

  ProductsListBloc() {
    _brandFilters.value = [];
    _categoryFilters.value = [];
    _searchTerm.value = "";
    _minRange.value = null;
    _maxRange.value = null;
    _sortBy.value = 'default';
  }

  getProducts({String searchTerm}) async {
    ProductResponse response = await _repository.getProducts(
        category: _currentCategory.value,
        categoryFilters: _categoryFilters.value.length > 0
            ? _categoryFilters.value.map((e) => e.slug).join(",")
            : null,
        sortBy: _sortBy.value,
        minPrice: _minRange.value,
        maxPrice: _maxRange.value,
        searchTerm: _searchTerm.value,
        // types: types,
        brands: _brandFilters.value.map((e) => e.slug).join(","));
    _subject.sink.add(response);
//    categoryBloc.selectedCategory = category;
//    _currentCategory.sink.add(category);
  }

//  getBrands(){
//    brandsBloc.getBrands(category: _category.value);
//  }

  void drainStream() {
    _subject.value = null;
    _brandFilters.value = [];
    _categoryFilters.value = [];
    _minRange.value = null;
    _maxRange.value = null;
    _sortBy.value = 'default';
  }

  void drainCategoryStream() {
    _currentCategory.value = null;
    _minRange.value = null;
    _maxRange.value = null;
    _sortBy.value = 'default';
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _currentCategory.drain();
    _currentCategory.close();

    await _minRange.drain();
    _minRange.close();

    await _maxRange.drain();
    _maxRange.close();

    await _sortBy.drain();
    _sortBy.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;

  BehaviorSubject<String> get currentCategory => _currentCategory;

  BehaviorSubject<List<Brand>> get brandFilters => _brandFilters;

  BehaviorSubject<List<Category>> get categoryFilters => _categoryFilters;

  BehaviorSubject<String> get searchTerm => _searchTerm;

  BehaviorSubject<String> get minRange => _minRange;

  BehaviorSubject<String> get maxRange => _maxRange;

  BehaviorSubject<String> get sortBy => _sortBy;

//  set addBrands(brand) => _brands.add(brand);
}

//final productsListBloc = ProductsListBloc();
