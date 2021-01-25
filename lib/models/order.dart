class Order {
  int id;
  String address;
  String bulkDiscountCost;
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
  String shippingDiscountCost;
  String status;
  String subTotal;
  String totalQuantity;
  String weight;
  String zipCode;
  String createdAt;
  String createdDate;
  String paymentStatus;
  String transactionId;
  String shippingCompany;

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
    this.transactionId,
    this.shippingCompany,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    bulkDiscountCost = json['bulk_discount_cost'].toString();
    city = json['city'];
    email = json['email'];
    house = json['house'];
    orderId = json['order_id'];
    paymentMethod = json['payment_method'];
    phone = json['phone'];
    prefecture = json['prefecture'];
    redeemedAmount = json['redeemed_amount']?.toString();
    shippingCost = json['shipping_cost']?.toString();
    shippingCompany = json['shipping_company']?.toString();
    shippingDiscountCost = json['shipping_discount_cost']?.toString();
    status = json['status'];
    subTotal = json['sub_total']?.toString();
    totalQuantity = json['total_quantity']?.toString();
    weight = json['weight']?.toString();
    zipCode = json['zip_code']?.toString();
    createdAt = json['created_at'];
    createdDate = json['created_date'];
    paymentStatus = json['payment_status'];
    transactionId = json['transaction_id'];
  }
}
