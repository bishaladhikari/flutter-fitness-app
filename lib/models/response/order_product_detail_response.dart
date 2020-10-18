import '../order_product_detail.dart';

class OrderProductDetailResponse {
  final List<OrderProductDetail> orderProductDetails;
  final String error;

  OrderProductDetailResponse(this.orderProductDetails, this.error);

  OrderProductDetailResponse.fromJson(Map<String, dynamic> json)
      : orderProductDetails = (json["data"] as List)
      .map((i) => new OrderProductDetail.fromJson(i))
      .toList(), error = "";

  OrderProductDetailResponse.withError(String errorValue)
      : orderProductDetails = List(),
        error = errorValue;
}
