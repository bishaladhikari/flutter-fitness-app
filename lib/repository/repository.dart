import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/models/response/banner_response.dart';
import 'package:ecapp/models/response/brand_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/models/response/customer_review_response.dart';
import 'package:ecapp/models/response/combo_detail_response.dart';
import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/models/response/error_response.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/models/response/loyalty_point_response.dart';
import 'package:ecapp/models/response/email_confirm_response.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_product_item_response.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:ecapp/models/response/redeem_point_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/models/response/search_suggestion_response.dart';
import 'package:ecapp/models/response/store_response.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class Repository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

//  static String appUrl = "http://ecsite-dashboard.test/api";

  Dio _dio;
  var loginUrl = '$appUrl/customer-login';
  var categoriesUrl = '$appUrl/categories';
  var productsUrl = '$appUrl/products';
  var ordersUrl = '$appUrl/orders';
  var wishlistUrl = '$appUrl/wishlist';
  var cartUrl = '$appUrl/cart';
  var addressUrl = '$appUrl/addresses';
  var brandsUrl = '$appUrl/brands';
  var bannerUrl = '$appUrl/all-banners';
  var registerUrl = '$appUrl/customer-register';
  var orderProductsUrl = '$appUrl/order-products';
  var removeFromWishlist = '$appUrl/remove-from-wishlist';
  var reviewProductUrl = '$appUrl/reviews';
  var comboProductUrl = '$appUrl/combos';
  var resendOTPUrl = '$appUrl/resend-otp';
  var confirmOTPUrl = '$appUrl/otp-confirmation';
  var forgotPasswordUrl = '$appUrl/customer/forget-password';
  var forgotPasswordUpdateUrl = '$appUrl/customer/update-password';
  var loyaltyPointsUrl = '$appUrl/loyalty-points';
  var redeemLoyaltyPointsUrl = '$appUrl/redeem-points';
  var searchSuggestionUrl = '$appUrl/search';
  var userProfileUrl = '$appUrl/customer/profile';
  var userProfileUpdateUrl = '$appUrl/customer/profile/update';
  var userPasswordUpdateUrl = '$appUrl/customer/change-password';
  var getStoreDetailUrl = '$appUrl/stores';

  Repository() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 30000);
    _dio = Dio(options);
    _dio.interceptors.addAll([
      InterceptorsWrapper(onRequest: (Options options) async {
        _dio.lock();
        options.headers["Accept"] = "application/json";
        options.headers["Content-Type"] = "application/json";
        _dio.unlock();
      }),
      // Append authorization
      InterceptorsWrapper(onRequest: (Options options) async {
        _dio.lock();
        await getToken().then((token) => {
              if (token != null)
                options.headers["Authorization"] = "Bearer " + token,
            });
        await authBloc.user.then(
            (user) => {if (user != null) options.headers["user"] = user.id});

        _dio.unlock();
      }),
      //Append language
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        if (!options.headers.containsKey("locale")) {
          _dio.lock();
          var locale = myApp.locale?.languageCode.toString() == 'ja'
              ? 'jp'
              : myApp.locale?.languageCode.toString();
//          var locale = 'jp';
          options.headers["locale"] = locale;
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

  getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user");
  }

  Future<LoginResponse> login(credentials) async {
    try {
      Response response =
          await _dio.post(loginUrl, queryParameters: credentials);
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
      Response response = await _dio.get(categoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CategoryResponse.withError(_handleError(error));
    }
  }

//  Future<ProductResponse> getProducts(int page) async {
//    var params = {"per_page": 10, "page": page};
//
//    try {
//      Response response = await _dio.get(productsUrl, queryParameters: params);
//      return ProductResponse.fromJson(response.data);
//    } catch (error, stacktrace) {
//      print("Exception occurred: $error stackTrace: $stacktrace");
//      return ProductResponse.withError(_handleError(error));
//    }
//  }

  Future<ProductResponse> getProductsFromSameSeller(
      int page, String slug) async {
    var params = {
      "per_page": 10,
      "page": page,
      "products_from_same_seller": slug,
      "combo": false
    };

    try {
      Response response = await _dio.get(productsUrl, queryParameters: params);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getRelatedProduct(slug, isCombo) async {
    try {
      Response response = await _dio.get(productsUrl,
          queryParameters: {"you_may_also_like": slug, "combo": isCombo});
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getSameSellerProduct(page, slug, isCombo) async {
    try {
      Response response = await _dio.get(productsUrl, queryParameters: {
        "page": page,
        "products_from_same_seller": slug,
        "combo": isCombo
      });
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<WishlistResponse> getWishlist() async {
    try {
      Response response = await _dio.get(wishlistUrl);
      return WishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WishlistResponse.withError(_handleError(error));
    }
  }

  Future<SearchSuggestionResponse> getSearchSuggestions(query) async {
    try {
      Response response =
          await _dio.get(searchSuggestionUrl + '?search_term=' + query);
      return SearchSuggestionResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return SearchSuggestionResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> getCart() async {
    try {
      Response response = await _dio.get(cartUrl);
      return CartResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CartResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> updateCart(cartItem, type) async {
    int qty = cartItem.quantity;
    if (type == "add") qty++;
    if (type == "sub") qty--;

    var params = {
      "attribute_id": cartItem.attribute?.id ?? null,
      "combo_id": cartItem.combo?.id ?? null,
      "id": cartItem.id,
      "quantity": qty
    };
    try {
      Response response = await _dio.put(cartUrl + "/" + cartItem.id.toString(),
          queryParameters: params);
      return CartResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CartResponse.withError(_handleError(error));
    }
  }

  Future<AddToCartResponse> addToCart(params) async {
    try {
      Response response = await _dio.post(cartUrl, queryParameters: params);
      return AddToCartResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return AddToCartResponse.withError(_handleError(error));
    }
  }

  Future<BannerResponse> getBanners() async {
    try {
      Response response = await _dio.get(bannerUrl);
      return BannerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BannerResponse.withError(_handleError(error));
    }
  }

  Future<AddressResponse> getAddresses() async {
    try {
      Response response = await _dio.get(addressUrl);
      return AddressResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return AddressResponse.withError(_handleError(error));
    }
  }

  Future<BrandResponse> getBrands(String category) async {
    try {
      print("fetching brands0" + category);

      Response response = await _dio.get(brandsUrl + "?category=" + category);
      print("fetching brands");

      return BrandResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return BrandResponse.withError(_handleError(error));
    }
  }

  Future<OrderResponse> getOrdersByStatus(status, pageNumber) async {
    var params = {"status": status, "page": pageNumber};
    try {
      Response response = await _dio.get(ordersUrl, queryParameters: params);
      return OrderResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return OrderResponse.withError(_handleError(error));
    }
  }

  // Future<OrderResponse> getSingleOrderDetail(int id) async {
  //   try {
  //     Response response = await _dio.get(ordersUrl + "/$id");
  //     return OrderResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return OrderResponse.withError(_handleError(error));
  //   }
  // }

  Future<OrderProductDetailResponse> getOrderItemDetail(int id) async {
    var params = {"order_id": id};
    try {
      Response response =
          await _dio.get(orderProductsUrl + "/$id", queryParameters: params);
      return OrderProductDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return OrderProductDetailResponse.withError(_handleError(error));
    }
  }

  Future<AddToWishlistResponse> addToWishlist(params) async {
    try {
      Response response = await _dio.post(wishlistUrl, queryParameters: params);
      return AddToWishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return AddToWishlistResponse.withError(_handleError(error));
    }
  }

  Future<RemoveFromWishlistResponse> deleteFromWishlist(params) async {
    try {
      Response response =
          await _dio.post(removeFromWishlist, queryParameters: params);
      return RemoveFromWishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return RemoveFromWishlistResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> deleteFromCartList(id) async {
    try {
      Response response = await _dio.delete(cartUrl + '/$id');
      return CartResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CartResponse.withError(_handleError(error));
    }
  }

  updateAddress(
      {@required id,
      @required name,
      phone,
      email,
      house,
      zipCode,
      city,
      address,
      prefecture}) async {
    try {
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
      Response response =
          await _dio.put(addressUrl + "/$id", queryParameters: data);
      return response;
    } catch (error, stacktrace) {
      return AddressResponse.withError(_handleError(error));
    }
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
      Response response = await _dio.post(addressUrl, queryParameters: data);

      return response;
    } catch (error, stacktrace) {
      return AddressResponse.withError(_handleError(error));
    }
  }

  Future<dynamic> registerCustomer(
      {@required fname,
      lname,
      email,
      mobile,
      password,
      cpassword,
      referCode}) async {
    try {
      final data = {
        "first_name": "$fname",
        "last_name": "$lname",
        "mobile": "$mobile",
        "email": "$email",
        "password": "$password",
        "confirm_password": "$cpassword",
        "refer_code": "$referCode"
      };
      final response = await _dio.post(registerUrl, queryParameters: data);
      return response;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      throw ErrorResponse.withError(_handleError(error));
    }
  }

  deleteWishlist(id) async {
    try {
      Response response = await _dio.delete(wishlistUrl + "/$id");
      // return WishlistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return WishlistResponse.withError(_handleError(error));
    }
  }

  Future<ProductDetailResponse> getProductDetail(String slug) async {
    try {
      Response response = await _dio.get(productsUrl + "/$slug");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductDetailResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getFeaturedProducts() async {
    try {
      Response response = await _dio.get(productsUrl + '?type=featured');
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getNewArrivals() async {
    try {
      Response response = await _dio.get(productsUrl + '?type=new_arrivals');
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ComboResponse> getComboProducts(params) async {
    try {
      Response response =
          await _dio.get(comboProductUrl, queryParameters: params);
      return ComboResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ComboResponse.withError(_handleError(error));
    }
  }

  Future<ComboDetailResponse> getComboDetail(String slug) async {
    try {
      Response response = await _dio.get(comboProductUrl + "/$slug");
      return ComboDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ComboDetailResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getBestSellers() async {
    try {
      Response response = await _dio.get(productsUrl + '?type=best_sellers');
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getTopRated() async {
    try {
      Response response = await _dio.get(productsUrl + '?type=top_rated');
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<ProductResponse> getProducts(params) async {
    // var params = {
    //   "category": categoryFilters == null ? category : null,
    //   "sub_categories": categoryFilters,
    //   "brands": brands,
    //   "sort_by": sortBy,
    //   "starting_price": minPrice,
    //   "ending_price": maxPrice,
    //   "types": types,
    //   "search_term": searchTerm,
    //   "per_page": 10,
    //   "page": page,
    // };
    try {
      Response response = await _dio.get(productsUrl, queryParameters: params);
      return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ProductResponse.withError(_handleError(error));
    }
  }

  Future<AddOrderResponse> createOrder(params) async {
    try {
      Response response = await _dio.post(ordersUrl, queryParameters: params);
      return AddOrderResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return AddOrderResponse.withError(_handleError(error));
    }
  }

  Future<ReviewResponse> getProductReview(
      String combo, String slug, int page) async {
    var params = {"combo": combo, "slug": slug, "per_page": 10, "page": page};

    try {
      Response response =
          await _dio.get(reviewProductUrl, queryParameters: params);
      return ReviewResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ReviewResponse.withError(_handleError(error));
    }
  }

  Future<OrderProductItemResponse> addProductReview(params) async {
    try {
      Response response =
          await _dio.post(reviewProductUrl, queryParameters: params);
      return OrderProductItemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return OrderProductItemResponse.withError(_handleError(error));
    }
  }

  Future<OrderProductItemResponse> updateProductReview(params, id) async {
    try {
      Response response =
          await _dio.put(reviewProductUrl + "/$id", queryParameters: params);
      return OrderProductItemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return OrderProductItemResponse.withError(_handleError(error));
    }
  }

  Future<CustomerReviewResponse> getProductReviewById(String id) async {
    try {
      Response response = await _dio.get(reviewProductUrl + "/$id");
      return CustomerReviewResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CustomerReviewResponse.withError(_handleError(error));
    }
  }

  Future<OrderProductItemResponse> deleteProductReview(id) async {
    try {
      Response response = await _dio.delete(reviewProductUrl + "/$id");
      return OrderProductItemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return OrderProductItemResponse.withError(_handleError(error));
    }
  }

  Future<EmailConfirmResponse> emailForgotPassword(params) async {
    try {
      Response response =
          await _dio.post(forgotPasswordUrl, queryParameters: params);
      return EmailConfirmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return EmailConfirmResponse.withError(_handleError(error));
    }
  }

  Future<EmailConfirmResponse> forgotPasswordUpdate(params) async {
    try {
      Response response =
          await _dio.post(forgotPasswordUpdateUrl, queryParameters: params);
      return EmailConfirmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return EmailConfirmResponse.withError(_handleError(error));
    }
  }

  Future<EmailConfirmResponse> resendOTPCode(params) async {
    try {
      Response response =
          await _dio.post(resendOTPUrl, queryParameters: params);
      return EmailConfirmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return EmailConfirmResponse.withError(_handleError(error));
    }
  }

  Future<EmailConfirmResponse> confirmEmailOTP(params) async {
    try {
      Response response =
          await _dio.post(confirmOTPUrl, queryParameters: params);
      return EmailConfirmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return EmailConfirmResponse.withError(_handleError(error));
    }
  }

  Future<LoyaltyPointResponse> loyaltyPoints(amount) async {
    var params = {'amount': amount};

    try {
      Response response =
          await _dio.post(loyaltyPointsUrl, queryParameters: params);
      return LoyaltyPointResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return LoyaltyPointResponse.withError(_handleError(error));
    }
  }

  Future<RedeemPointResponse> redeemLoyaltyPoints(params) async {
    try {
      Response response =
          await _dio.post(redeemLoyaltyPointsUrl, queryParameters: params);
      return RedeemPointResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return RedeemPointResponse.withError(_handleError(error));
    }
  }

  Future<ProfileResponse> userProfile() async {
    try {
      Response response = await _dio.post(userProfileUrl);
      return ProfileResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print(['erro', error]);
      return ProfileResponse.withError(_handleError(error));
    }
  }

  Future<ProfileResponse> userProfileUpdate(params) async {
    try {
      Response response =
          await _dio.post(userProfileUpdateUrl, queryParameters: params);
      return ProfileResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return ProfileResponse.withError(_handleError(error));
    }
  }

  Future<EmailConfirmResponse> userPasswordUpdate(params) async {
    try {
      Response response =
          await _dio.post(userPasswordUpdateUrl, queryParameters: params);
      return EmailConfirmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return EmailConfirmResponse.withError(_handleError(error));
    }
  }

  Future<StoreResponse> getStoreDetail(String storeSlug) async {
    try {
      Response response = await _dio.get(getStoreDetailUrl + "/" + storeSlug);
      return StoreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return StoreResponse.withError(_handleError(error));
    }
  }

  String _handleError(error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "No internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          switch (dioError.response.statusCode) {
            case 401:
              errorDescription = "unauthenticated";
              break;
            case 422:
              if (dioError.response.data["errors"] != null) {
//              var errors =
//                '{"email": ["The email must be a valid email address.","second email error"],"password":["passoword error1","passoword error2"]}';
//              errors = json.encode(errors);
                var errors = json.encode(dioError.response?.data["errors"]);
                errorDescription = json
                    .decode(errors)
                    .values
                    .toList()
                    .map((v) => v.join("\n"))
                    .join("\n");
              } else if (dioError.response.data["message"] != null)
                errorDescription = dioError.response.data["message"];
              else
                errorDescription = dioError.response.statusMessage;
              break;
            case 500:
              if (dioError.response.data["message"] != null)
                errorDescription = dioError.response.data["message"];
              else
                errorDescription = "something went wrong on server";
              break;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }
}
