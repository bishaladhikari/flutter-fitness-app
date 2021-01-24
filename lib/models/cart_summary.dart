class CartSummary {
  int bulkDiscountCost;
  int shippingCost;
  int shippingDiscountCost;
  double totalAmount;
  int totalItems;
  double totalWeight;

  CartSummary(
      {this.bulkDiscountCost,
        this.shippingCost,
        this.shippingDiscountCost,
        this.totalAmount,
        this.totalItems,
        this.totalWeight});

  CartSummary.fromJson(Map<String, dynamic> json) {
    bulkDiscountCost = json['bulk_discount_cost'];
    shippingCost = json['shipping_cost'];
    shippingDiscountCost = json['shipping_discount_cost'];
    totalAmount = double.parse((json['total_amount']).toStringAsFixed(2));
    totalItems = json['total_items'];
    totalWeight = json['total_weight']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bulk_discount_cost'] = this.bulkDiscountCost;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_discount_cost'] = this.shippingDiscountCost;
    data['total_amount'] = this.totalAmount;
    data['total_items'] = this.totalItems;
    data['total_weight'] = this.totalWeight;
    return data;
  }
}