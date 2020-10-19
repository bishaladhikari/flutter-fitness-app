import 'package:ecapp/models/cart_item.dart';

class AddToWishlistResponse {
  CartItem cartItem;
  final String error;

  AddToWishlistResponse(this.cartItem, this.error);

  AddToWishlistResponse.fromJson(Map<String, dynamic> json)
      : cartItem = CartItem.fromJson(json["data"]),
        error = null;

  AddToWishlistResponse.withError(String errorValue)
      : cartItem = null,
        error = errorValue;
}
