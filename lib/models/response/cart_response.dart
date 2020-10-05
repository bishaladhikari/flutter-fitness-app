import 'package:ecapp/models/wish.dart';

import '../cart.dart';

class CartResponse {
  List<Cart> Carts;
  final String error;

  void deleteFromCarts(id) {
    Carts.removeWhere((element) => element.id == id);
  }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  CartResponse(this.Carts, this.error);

  CartResponse.fromJson(Map<String, dynamic> json)
      : Carts =
            (json["data"] as List).map((i) => new Cart.fromJson(i)).toList(),
        error = "";

  CartResponse.withError(String errorValue)
      : Carts = List(),
        error = errorValue;
}
