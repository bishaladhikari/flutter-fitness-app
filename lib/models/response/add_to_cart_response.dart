import 'package:ecapp/models/cart_item.dart';

import '../product_detail.dart';

class AddToCartResponse {
  CartItem cartItem;
  final String error;

  AddToCartResponse(this.cartItem, this.error);

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : cartItem = CartItem.fromJson(json["data"]),
        error = null;

  AddToCartResponse.withError(String errorValue)
      : cartItem = CartItem(),
        error = errorValue;
}
