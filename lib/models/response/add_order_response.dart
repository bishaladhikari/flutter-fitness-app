import 'package:ecapp/models/cart_item.dart';

import '../product_detail.dart';

class AddOrderResponse {
  String orderId;
  final String error;

  AddOrderResponse(this.orderId, this.error);

  AddOrderResponse.fromJson(Map<String, dynamic> json)
      : orderId = json["data"],
        error = null;

  AddOrderResponse.withError(String errorValue)
      : orderId = null,
        error = errorValue;
}
