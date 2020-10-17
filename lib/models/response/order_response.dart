import '../order.dart';

class OrderResponse {
  final List<Order> orders;
  final String error;

  OrderResponse(this.orders, this.error);

  OrderResponse.fromJson(Map<String, dynamic> json)
      : orders = (json["data"] as List)
      .map((i) => new Order.fromJson(i))
      .toList(), error = "";

  OrderResponse.withError(String errorValue)
      : orders = List(),
        error = errorValue;
}