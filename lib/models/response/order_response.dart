import 'package:ecapp/models/links.dart';
import 'package:ecapp/models/meta.dart';

import '../order.dart';

class OrderResponse {
  final List<Order> orders;
  final String error;
  final Meta meta;

  OrderResponse(this.orders, this.error, this.meta);

  OrderResponse.fromJson(Map<String, dynamic> json)
      : orders =
            (json["data"] as List).map((i) => new Order.fromJson(i)).toList(),
        meta = Meta.fromJson(json["meta"]),
        error = null;

  OrderResponse.withError(String errorValue)
      : orders = List(),
        meta = Meta(),
        error = errorValue;
}
