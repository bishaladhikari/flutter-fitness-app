import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiResponse {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";
  final Dio _dio = Dio();

  var loginUrl = '$appUrl/customer-login';
  var categoriesUrl = '$appUrl/categories';
  var productsUrl = '$appUrl/products';
  var featuredProductsUrl = '$appUrl/products?type=new_arrivals';

  var _jsonResponse;

  get(url, {headers}) async {
    try {
      _jsonResponse = null;
      final response = await _dio.get(url, options: Options(headers: headers));
      _jsonResponse = _requestRespone(response);
    } on SocketException {
      throw "Error due to internet connection";
    }
    return _jsonResponse;
  }

  post(url, {headers, body}) async {}

  _requestRespone(response) {
    switch (response.statusCose) {
      case 200:
        return json.decode(response.body);
        break;
      default:
        return "Error with status code:${response.statusCode}";
    }
  }
}
