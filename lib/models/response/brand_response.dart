import '../brand.dart';

class BrandResponse {
  List<Brand> brands;
  final String error;

  // void deleteFromWishList(id) {
  //   wishes.removeWhere((element) => element.id == id);
  // }

//
//   void addWish(Wish wish) {
//     wishes.add(wish);
//   }

  BrandResponse(this.brands, this.error);

  BrandResponse.fromJson(Map<String, dynamic> json)
      : brands =
            (json["data"] as List).map((i) => new Brand.fromJson(i)).toList(),
        error = null;

  BrandResponse.withError(String errorValue)
      : brands = List(),
        error = errorValue;
}
