
import '../address.dart';

class AddressResponse {
  List<Address> addresses;
  final String error;

  // void deleteFromWishList(id) {
  //   wishes.removeWhere((element) => element.id == id);
  // }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  AddressResponse(this.addresses, this.error);

  AddressResponse.fromJson(Map<String, dynamic> json)
      : addresses =
            (json["data"] as List).map((i) => new Address.fromJson(i)).toList(),
        error = null;

  AddressResponse.withError(String errorValue)
      : addresses = List(),
        error = errorValue;
}
