import '../cart.dart';

class CartResponse {
  List<Cart> carts;
  int totalItems;
  double totalAmount;
  String totalWeight;
  int shippingDiscountCost;
  int bulkDiscountCost;
  List<Null> achievedPromotions;
  int shippingCost;
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
      : carts = (json["data"]["data"] as List)
            .map((i) => new Cart.fromJson(i))
            .toList(),
        totalItems = json["data"]['total_items'],
        totalAmount = json["data"]['total_amount'].toDouble(),
        totalWeight = json["data"]['total_weight'].toString(),
        shippingDiscountCost = json["data"]['shipping_discount_cost'],
        bulkDiscountCost = json["data"]['bulk_discount_cost'],
        shippingCost = json["data"]['shipping_cost'],
        error = "";

  CartResponse.withError(String errorValue)
      : carts = List(),
        error = errorValue;
}
