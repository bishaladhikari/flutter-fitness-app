import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'dart:developer';

import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/user.dart';
import 'package:ecapp/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

//  static String appUrl = "http://ecsite-dashboard.test/api";

  Dio _dio;
  var loginUrl = '$appUrl/customer-login';
  var categoriesUrl = '$appUrl/categories';
  var productsUrl = '$appUrl/products';
  var wishlistUrl = '$appUrl/wishlist';
  var cartUrl = '$appUrl/cart';
  var featuredProductsUrl = '$appUrl/products?type=new_arrivals';
  var addressUrl = '$appUrl/addresses';

  Repository() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
//    print("is called");
    _dio.interceptors.addAll([
      InterceptorsWrapper(onRequest: (Options options) async {
        _dio.lock();
        options.headers["Accept"] = "application/json";
        _dio.unlock();
      }),
      // Append authorization
      InterceptorsWrapper(onRequest: (Options options) async {
        _dio.lock();
        await getToken().then((token) => {
              if (token != null)
                options.headers["Authorization"] = "Bearer " + token
//            options.headers["Authorization"] ="Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c"
            });

        _dio.unlock();
      }),
      //Append language
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        if (!options.headers.containsKey("locale")) {
          _dio.lock();
          options.headers["locale"] = "jp";
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
      Response response =
          await _dio.post(loginUrl, queryParameters: credentials);
//      print(response.data);
//      SharedPreferences pref = await SharedPreferences.getInstance();
//      pref.setString("token", json.encode(response.data['token']));
//      pref.setString("user", json.encode(response.data['user']));
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return LoginResponse.withError(_handleError(error));
    }
  }

  Future<CategoryResponse> getCategories() async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(categoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CategoryResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getProducts() async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getRelatedProduct(slug) async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl,
          queryParameters: {"you_may_also_like": slug, "combo": false});
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getSameSellerProduct(slug) async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl,
          queryParameters: {"products_from_same_seller": slug, "combo": false});
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<WishlistResponse> getWishlist() async {
    try {
//      _dio.options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c";
//      _dio.options.headers["locale"] = "jp";
//
      Response response = await _dio.get(wishlistUrl);
      return WishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WishlistResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> getCart() async {
    try {
//      _dio.options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c";
//      _dio.options.headers["locale"] = "jp";
//
      Response response = await _dio.get(cartUrl);
      return CartResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CartResponse.withError(_handleError(error));
    }
  }

  Future<AddressResponse> getAddress() async {
    try {
//      _dio.options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c";
//      _dio.options.headers["locale"] = "jp";
//
      Response response = await _dio.get(addressUrl);
      print("Response:" + response.toString());

      return AddressResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return AddressResponse.withError(_handleError(error));
    }
  }

  updateAddress(){

  }
  Future<dynamic> addAddress(
      {@required name,
      phone,
      email,
      house,
      zipCode,
      city,
      address,
      prefecture}) async {
    try {
//      _dio.options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c";
//      _dio.options.headers["locale"] = "jp";
//
print("jell");
      final data = {
        "full_name": "$name",
        "phone": "$phone",
        "email": "$email",
        "house": "$house",
        "zip_code": "$zipCode",
        "address_type": "Shipping Address",
        "address": "$address",
        "city": "$city",
        "prefecture": "$prefecture",
      };
      print("name:" + name.toString());
      Response response = await _dio.post(addressUrl, queryParameters: data);
      print("Response:" + response.toString());

      return response;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return AddressResponse.withError(_handleError(error));
    }
  }

  deleteWishlist(id) async {
    try {
      //  _dio.options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZmODgyZjc0YzU2NmZjMzE2NGM5NmE3Nzk3ZDkxYmJiZmI5MzFlOGMwMmNiMzQwM2M1OTNlYjM4ODQxY2M5NGQzYjMwYWMzODMxMmE5NGYiLCJpYXQiOjE2MDE0NTg2MjIsIm5iZiI6MTYwMTQ1ODYyMiwiZXhwIjoxNjMyOTk0NjIyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.JAKMMl2GdTRLL7SO_PzfSLTcw2FDzYfypePiMNX88ysInlI4A6cqJnP_0b4Frme6UafLLuS9adRkCKhfb0D9meK31yRt55Y6w-NiXA5S92wREgMLBObnKuHoq1h7T-mzKmkFEl71vZIv8YliJkDCV48DGmb97BtF0Hy6W9yIXsXTp74cFY3y-3HuSqyw2N4PCRIvQmpK_PNab0GMUjZqYAsEs-7XJL11beQsHzMu7AG9N9pJjvmJnM4mqxdJbgO10ahhBbnaEE6AZ-EJxOvNYMG_A8udi9-4fevjBNhbEdBp9iAygdC3fn84Y1D92B_7DWVPkY0Cgy2dNJ6pzbcWn-UPKqAcR06w4RFjkyy58RYNie10bpMpPXxmiLxxGhvpRrr7JEeoBQUwQAlnutgvXjKfzz7mZx2W86-JrsduA99x5-KDOYr3bt0oeD82NfGaz7arHghnjblaJSo5SXjQan80-_u3cSbJJi65oSQ_xCkb7306KFlFH5SM7CS4Z_DU7ViDt5NSBcg9hXfhAzfAxz10lhyp__kIobknEXw1mUZvkbSQ__K_fUFeGhMUhpyAvRf5RB6AXkjXZvKdRozOsNFRovnAIqrfkZLDUAcfCaAkYDNjX1yCxNxjVnaCPaBhg6riEchoUm15sQnHC36SrTV_AsbZBG08ICd6qjmnu0c";
      //  _dio.options.headers["locale"] = "jp";
      Response response = await _dio.post(wishlistUrl + "/$id");
      print("Response:" + response.toString());
      // return WishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WishlistResponse.withError(_handleError(error));
    }
  }

  Future<ProductDetailResponse> getProductDetail(String slug) async {
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl + "/$slug");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductDetailResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getFeaturedProducts() async {
//    try {
////      _dio.options.headers = {"locale": "jp"};
//      Response response = await _dio.get(featuredProductsUrl);
//      return FeaturedProductResponse.fromJson(response.data);
//    } catch (error, stacktrace) {
//      print("Exception occurred: $error stackTrace: $stacktrace");
//      return FeaturedProductResponse.withError(_handleError(error));
//    }
    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(featuredProductsUrl);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getCategoryProducts(
      String category, String sortBy) async {
    var params = {"category": category, "sort_by": sortBy};

    try {
//      _dio.options.headers = {"locale": "jp"};
      Response response = await _dio.get(productsUrl, queryParameters: params);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
