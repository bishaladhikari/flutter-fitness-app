import 'package:ecapp/models/wish.dart';

class WishlistResponse {
  final List<Wish> wishes;
  final String error;

  WishlistResponse(this.wishes, this.error);

  WishlistResponse.fromJson(Map<String, dynamic> json)
      : wishes = (json["data"] as List)
            .map((i) => new Wish.fromJson(i))
            .toList(),
        error = "";

  WishlistResponse.withError(String errorValue)
      : wishes = List(),
        error = errorValue;
}
