import 'package:dio/dio.dart';
import 'package:ecapp/models/category_response.dart';
import 'dart:developer';

import 'package:ecapp/models/product_response.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";
//  static String appUrl = "http://ecsite-dashboard.test/api";

  final Dio _dio = Dio();

  var getCategoriesUrl = '$appUrl/categories';
  var getProductsUrl = '$appUrl/products';

  Future<CategoryResponse> getCategories() async {
    try {
      _dio.options.headers= {"locale" : "jp"};
      Response response = await _dio.get(getCategoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CategoryResponse.withError("$error");
    }
  }
  Future<ProductResponse> getProducts() async {
    try {
      _dio.options.headers= {"locale" : "jp"};
      Response response = await _dio.get(getProductsUrl);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }
}
