import 'package:ecapp/models/wish.dart';

class WishlistResponse {
  List<Wish> wishes;
  final String error;

  void deleteFromWishList(id) {
    wishes.removeWhere((element) => element.id == id);
  }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  WishlistResponse(this.wishes, this.error);

  WishlistResponse.fromJson(Map<String, dynamic> json)
      : wishes =
            (json["data"] as List).map((i) => new Wish.fromJson(i)).toList(),
        error = "";

  WishlistResponse.withError(String errorValue)
      : wishes = List(),
        error = errorValue;
}
