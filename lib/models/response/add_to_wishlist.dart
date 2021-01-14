import 'package:ecapp/models/cart_item.dart';

class AddToWishlistResponse {
  CartItem cartItem;
  final String error;

  AddToWishlistResponse(this.cartItem, this.error);

  AddToWishlistResponse.fromJson(Map<String, dynamic> json)
      : cartItem = json["data"]?CartItem.fromJson(json["data"]):CartItem(),
        error = null;

  AddToWishlistResponse.withError(String errorValue)
      : cartItem = null,
        error = errorValue;
}
