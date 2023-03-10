// import 'dart:js';
// import 'package:fitnessive/bloc/brands_bloc.dart';
import 'package:fitnessive/models/brand.dart';
import 'package:fitnessive/models/category.dart';
import 'package:fitnessive/models/response/product_response.dart';
import 'package:fitnessive/repository/repository.dart';
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
  final BehaviorSubject<String> _searchTerm = BehaviorSubject<String>();

  final BehaviorSubject<String> _currentCategory = BehaviorSubject<String>();
  final BehaviorSubject<String> _minRange = BehaviorSubject<String>();
  final BehaviorSubject<String> _maxRange = BehaviorSubject<String>();
  final BehaviorSubject<String> _sortBy = BehaviorSubject<String>();
  final BehaviorSubject<String> _types = BehaviorSubject<String>();
  final BehaviorSubject<int> _page = BehaviorSubject<int>();
  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  final BehaviorSubject<String> _storeSlug = BehaviorSubject<String>();

  ProductResponse productResponse;

  ProductsListBloc() {
    _brandFilters.value = [];
    _categoryFilters.value = [];
    _searchTerm.value = "";
    _minRange.value = null;
    _maxRange.value = null;
    _currentCategory.value = null;
    _sortBy.value = 'default';
    _types.value = null;
    _page.value = 1;
    _storeSlug.value = null;
  }

  getProducts({String searchTerm}) async {
    _loading.sink.add(true);
    var params = {
      "category": _currentCategory.value,
      "sub_categories": _categoryFilters.value.length > 0
          ? _categoryFilters.value.map((e) => e.slug).join(",")
          : null,
      "sort_by": _sortBy.value,
      "starting_price": _minRange.value,
      "ending_price": _maxRange.value,
      "search_term": _searchTerm.value,
      "types": _types.value,
      "page": _page.value,
//      "per_page":4,
      "brands": _brandFilters.value.map((e) => e.slug).join(","),
      "store": _storeSlug.value,
    };

    ProductResponse response = await _repository.getProducts(params);

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
    _subject.sink.add(productResponse);
  }

  void drainStream() {
    _subject.value = null;
    _brandFilters.value = [];
    _categoryFilters.value = [];
    _minRange.value = null;
    _maxRange.value = null;
    _sortBy.value = 'default';
    _types.value = null;
    _page.value = null;
    productResponse = null;
    _storeSlug.value = null;
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

  BehaviorSubject<String> get types => _types;

  BehaviorSubject<int> get page => _page;

  Stream<bool> get loading => _loading.stream;

  BehaviorSubject<String> get storeSlug => _storeSlug;
}

//final productsListBloc = ProductsListBloc();
