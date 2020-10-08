import '../cart.dart';

class CartResponse {
  List<Cart> carts;
  int totalItems;
  int totalAmount;
  double totalWeight;
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
        totalItems = json['total_items'],
        totalAmount = json['total_amount'],
        totalWeight = json['total_weight'],
        shippingDiscountCost = json['shipping_discount_cost'],
        bulkDiscountCost = json['bulk_discount_cost'],
        shippingCost = json['shipping_cost'],
        error = "";

  CartResponse.withError(String errorValue)
      : carts = List(),
        error = errorValue;
}
