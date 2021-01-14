import 'package:ecapp/models/cart_item.dart';

class AddToCartResponse {
  int totalItems;
  double totalAmount;
  String totalWeight;
  final String error;

  AddToCartResponse(this.error);

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      :
        totalItems = json['cart_summary']['total_items'] != null
            ? json['cart_summary']['total_items']
            : 0,
        totalAmount = json['cart_summary']['total_amount'].toDouble(),
        totalWeight = json['cart_summary']['total_weight'].toString(),
        error = null;

  AddToCartResponse.withError(String errorValue) : error = errorValue;
}
