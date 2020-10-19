import 'package:ecapp/models/cart_item.dart';

class RemoveFromWishlistResponse {
  final String error;

  RemoveFromWishlistResponse(this.error);

  RemoveFromWishlistResponse.fromJson(Map<String, dynamic> json) : error = null;

  RemoveFromWishlistResponse.withError(String errorValue) : error = errorValue;
}