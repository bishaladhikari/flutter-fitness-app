import 'package:ecapp/models/wish.dart';

import '../cart.dart';

class CartResponse {
  List<Cart> carts;
  final String error;

  void deleteFromCarts(id) {
    carts.removeWhere((element) => element.id == id);
  }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  CartResponse(this.carts, this.error);

  CartResponse.fromJson(Map<String, dynamic> json)
      : carts =
            (json["data"] as List).map((i) => new Cart.fromJson(i)).toList(),
        error = "";

  CartResponse.withError(String errorValue)
      : carts = List(),
        error = errorValue;
}
