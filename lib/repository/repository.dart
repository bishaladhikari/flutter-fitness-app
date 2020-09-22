import 'package:dio/dio.dart';
import 'package:ecapp/models/category_response.dart';
import 'dart:developer';

class EcomRepository {
  static String appUrl = "http://ecsite.eeeinnovation.com/api";

  final Dio _dio = Dio();

  var getCategoriesUrl = '$appUrl/categories';

  Future<CategoryResponse> getCategories() async {
    try {
      _dio.options.headers= {"locale" : "jp"};
      Response response = await _dio.get(getCategoriesUrl);
      return CategoryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CategoryResponse.withError("$error");
    }
  }
}
