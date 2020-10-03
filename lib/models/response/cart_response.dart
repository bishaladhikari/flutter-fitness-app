import 'package:ecapp/models/wish.dart';

class CartResponse {
  List<Wish> wishes;
  final String error;

  void deleteFromWishList(id) {
    wishes.removeWhere((element) => element.id == id);
  }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  CartResponse(this.wishes, this.error);

  CartResponse.fromJson(Map<String, dynamic> json)
      : wishes =
            (json["data"] as List).map((i) => new Wish.fromJson(i)).toList(),
        error = "";

  CartResponse.withError(String errorValue)
      : wishes = List(),
        error = errorValue;
}
