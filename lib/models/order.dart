class Order {
  int id;
  String address;
  int bulkDiscountCost;
  String city;
  String email;
  String house;
  String name;
  String orderId;
  String paymentMethod;
  String phone;
  String prefecture;
  String redeemedAmount;
  String shippingCost;
  int shippingDiscountCost;
  String status;
  int subTotal;
  int totalQuantity;
  String weight;
  String zipCode;
  String createdAt;
  String createdDate;
  String paymentStatus;

  Order({
    this.id,
    this.name,
    this.address,
    this.bulkDiscountCost,
    this.city,
    this.email,
    this.house,
    this.orderId,
    this.paymentMethod,
    this.phone,
    this.prefecture,
    this.redeemedAmount,
    this.shippingCost,
    this.shippingDiscountCost,
    this.status,
    this.subTotal,
    this.totalQuantity,
    this.weight,
    this.zipCode,
    this.createdAt,
    this.createdDate,
    this.paymentStatus,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    bulkDiscountCost = json['bulk_discount_cost'];
    city = json['city'];
    email = json['email'];
    house = json['house'];
    orderId = json['order_id'];
    paymentMethod = json['payment_method'];
    phone = json['phone'];
    prefecture = json['prefecture'];
    redeemedAmount = json['redeemed_amount'];
    shippingCost = json['shipping_cost'];
    shippingDiscountCost = json['shipping_discount_cost'];
    status = json['status'];
    subTotal = json['sub_total'];
    totalQuantity = json['total_quantity'];
    weight = json['weight'];
    zipCode = json['zip_code'];
    createdAt = json['created_at'];
    createdDate = json['created_date'];
    paymentStatus = json['payment_status'];
  }
}
