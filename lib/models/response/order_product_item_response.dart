import 'package:fitnessive/models/order_product_detail.dart';

class OrderProductItemResponse {
  OrderProductDetail orderProductItem;
  final String error;

  OrderProductItemResponse(this.orderProductItem, this.error);

  OrderProductItemResponse.fromJson(Map<String, dynamic> json)
      : orderProductItem = OrderProductDetail.fromJson(json["data"]),
        error = null;

  OrderProductItemResponse.withError(String errorValue)
      : orderProductItem = OrderProductDetail(),
        error = errorValue;
}
