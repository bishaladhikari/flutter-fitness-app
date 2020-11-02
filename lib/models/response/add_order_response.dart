import '../order.dart';

class AddOrderResponse {
  Order order;
  final String error;

  AddOrderResponse(this.order, this.error);

  AddOrderResponse.fromJson(Map<String, dynamic> json)
      : order = Order.fromJson(json["data"]),
        error = null;

  AddOrderResponse.withError(String errorValue)
      : order = null,
        error = errorValue;
}
