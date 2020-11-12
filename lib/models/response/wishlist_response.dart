import 'package:ecapp/models/cart.dart';

class WishlistResponse {
  List<Cart> wishes;
  final String error;

  void deleteFromWishList(id) {
    wishes.forEach((wish) {
      wish.items.removeWhere((item) => item.id == id);
    });
//    wishes.removeWhere((element) => element.items == id);
  }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  WishlistResponse(this.wishes, this.error);

  WishlistResponse.fromJson(Map<String, dynamic> json)
      : wishes =
            (json["data"] as List).map((i) => new Cart.fromJson(i)).toList(),
        error = "";

  WishlistResponse.withError(String errorValue)
      : wishes = List(),
        error = errorValue;
}
