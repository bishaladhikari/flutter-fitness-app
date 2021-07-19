import 'package:rakurakubazzar/models/cart_summary.dart';
import 'package:rakurakubazzar/models/promotion_item.dart';

import '../cart.dart';

class CartResponse {
  List<Cart> carts;
  int totalItems;

  // double totalAmount;
  // String totalWeight;
  // int shippingDiscountCost;
  // int bulkDiscountCost;
  List<AchievedPromotion> achievedPromotions;
  List<PromotionItem> platformPromotions;

  // int shippingCost;
  final String error;
  CartSummary cartSummary;

//  void deleteFromCarts(id) {
//    carts.removeWhere((element) => element.id == id);
//  }

  CartResponse(this.carts, this.cartSummary, this.achievedPromotions,
      this.platformPromotions, this.error);

  CartResponse.fromJson(Map<String, dynamic> json)
      : carts = (json["data"]["data"] as List)
            .map((i) => new Cart.fromJson(i))
            .toList(),
        achievedPromotions = (json["data"]["achieved_promotions"] as List)
            .map((i) => new AchievedPromotion.fromJson(i))
            .toList(),
        platformPromotions = (json["data"]["platform_promotions"] as List)
            .map((i) => new PromotionItem.fromJson(i))
            .toList(),
        cartSummary = CartSummary.fromJson(json["data"]),
        error = null;

  // totalItems = json["data"]['total_items']!=null?json["data"]['total_items']:0,
  // totalAmount = json["data"]['total_amount'].toDouble(),
  // totalWeight = json["data"]['total_weight'].toString(),
  // shippingDiscountCost = json["data"]['shipping_discount_cost'],
  // bulkDiscountCost = json["data"]['bulk_discount_cost'],
  // shippingCost = json["data"]['shipping_cost'],
  // error = null;

  CartResponse.withError(String errorValue)
      : carts = List(),
        cartSummary = CartSummary(),
        error = errorValue;
}

class AchievedPromotion {
  final discount;
  final id;
  final error;

  AchievedPromotion(this.discount, this.id, this.error);

  AchievedPromotion.fromJson(Map<String, dynamic> json)
      : discount = json["discount"],
        id = json["id"],
        error = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['discount'] = discount;
    return data;
  }

  AchievedPromotion.withError(String errorValue)
      : discount = null,
        id = null,
        error = errorValue;
}
