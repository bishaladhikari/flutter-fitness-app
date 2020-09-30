import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

//  static String appUrl = "http://ecsite-dashboard.test/api";

  final Dio _dio = Dio();

  var loginUrl = '$appUrl/customer-login';
  var categoriesUrl = '$appUrl/categories';
  var productsUrl = '$appUrl/products';
  var wishlistsUrl = '$appUrl/wishlists';
  var featuredProductsUrl = '$appUrl/products?type=new_arrivals';

  Repository() {
//    print("is called");
    _dio.interceptors.addAll([
      // Append authorization
      InterceptorsWrapper(onRequest: (RequestOptions options) async {
        _dio.lock();
        await getToken().then((token) => {
          if (token != null)
            _dio.options.headers["authorization"] = 'Bearer ' + token
        });

        _dio.unlock();
      }),
      // Append language
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        if (!options.headers.containsKey("locale")) {
          _dio.lock();
          options.headers = {"locale": "jp"};
          _dio.unlock();
        }
      }),
      // Debug request
      LogInterceptor(requestBody: true, responseBody: true)
    ]);
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString("token");
  }



  Future<LoginResponse> login(credentials) async {
    print(credentials);
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.post(loginUrl, queryParameters: credentials);
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
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(categoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CategoryResponse.withError("$error");
    }
  }

  Future<ProductResponse> getProducts() async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  Future<WishlistResponse> getWishlist() async {
    try {
      Response response = await _dio.get(wishlistsUrl);
      return WishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WishlistResponse.withError("$error");
    }
  }

  Future<ProductDetailResponse> getProductDetail(String slug) async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl + "/$slug");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductDetailResponse.withError("$error");
    }
  }

  Future<FeaturedProductResponse> getFeaturedProducts() async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(featuredProductsUrl);
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
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl, queryParameters: params);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }
}
