import 'package:dio/dio.dart';
import 'package:ecapp/models/category_response.dart';
import 'package:ecapp/models/featured_product_response.dart';
import 'dart:developer';

import 'package:ecapp/models/product_response.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

//  static String appUrl = "http://ecsite-dashboard.test/api";

  final Dio _dio = Dio();

  var getCategoriesUrl = '$appUrl/categories';
  var getProductsUrl = '$appUrl/products';
  var getFeaturedProductsUrl = '$appUrl/products?type=new_arrivals';

  Future<CategoryResponse> getCategories() async {
    try {
      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(getCategoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CategoryResponse.withError("$error");
    }
  }

  Future<ProductResponse> getProducts() async {
    try {
      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(getProductsUrl);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  Future<FeaturedProductResponse> getFeaturedProducts() async {
    try {
      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(getFeaturedProductsUrl);
      return FeaturedProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return FeaturedProductResponse.withError("$error");
    }
  }

  Future<ProductResponse> getCategoryProducts(
      String category, String sortBy) async {
    var params = {"categories": category, "sort_by": sortBy};

    try {
      _dio.options.headers = {"locale": "jp"};
      Response response =
          await _dio.get(getProductsUrl, queryParameters: params);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }
}
