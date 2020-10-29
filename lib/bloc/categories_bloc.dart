import 'package:ecapp/bloc/products_by_category_bloc.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CategoryResponse> _subject =
      BehaviorSubject<CategoryResponse>();

  final BehaviorSubject<ProductsListByCategoryBloc> _productsByCategoryBloc = BehaviorSubject<ProductsListByCategoryBloc>();

  set productsByCategoryBloc(productsByCategoryBloc) {
    _productsByCategoryBloc.sink.add(productsByCategoryBloc);
  }

  getCategories() async {
    CategoryResponse response = await _repository.getCategories();
    _subject.sink.add(response);
  }
  sortProducts(context,String sortBy) {
    const minPrice = '';
    const maxPrice = '';
    const types = '';

    productsByCategoryBloc
      .getCategoryProducts(productsByCategoryBloc.category.value, sortBy,
          minPrice, maxPrice, types);
    Navigator.of(context).pop();
  }
  void drainStream() {
//    _subject.value = null;
    _productsByCategoryBloc.value = null;
  }

  dispose() {
    _subject.close();
    _productsByCategoryBloc.close();
  }

  BehaviorSubject<CategoryResponse> get subject => _subject;
  get productsByCategoryBloc => _productsByCategoryBloc.value;
}

final categoryBloc = CategoriesListBloc();
