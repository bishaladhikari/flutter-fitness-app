import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

//  static String appUrl = "http://ecsite-dashboard.test/api";

  final Dio _dio = Dio();

  var loginUrl = '$appUrl/customer-login';
  var getCategoriesUrl = '$appUrl/categories';
  var getProductsUrl = '$appUrl/products';
  var getFeaturedProductsUrl = '$appUrl/products?type=new_arrivals';

  Future<LoginResponse> login(credentials) async {
    print(credentials);
    try {
      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.post(loginUrl,
          data: credentials);
//      print(response.data);
//      SharedPreferences pref = await SharedPreferences.getInstance();
//      pref.setString("token", json.encode(response.data['token']));
//      pref.setString("user", json.encode(response.data['user']));
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return LoginResponse.withError("$error");
    }
  }

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

  Future<ProductResponse> getCategoryProducts(String category) async {
    var params = {
      "category": category,
    };

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
