class Order {
  int id;
  String address;
  int bulk_discount_cost;
  String city;
  String email;
  String house;
  String name;
  String order_id;
  String payment_method;
  String phone;
  String prefecture;
  String redeemed_amount;
  String shipping_cost;
  int shipping_discount_cost;
  String status;
  int sub_total;
  int total_quantity;
  String weight;
  String zip_code;
  String created_at;
  String created_date;
  String payment_status;

  Order({
    this.id,
    this.name,
    this.address,
    this.bulk_discount_cost,
    this.city,
    this.email,
    this.house,
    this.order_id,
    this.payment_method,
    this.phone,
    this.prefecture,
    this.redeemed_amount,
    this.shipping_cost,
    this.shipping_discount_cost,
    this.status,
    this.sub_total,
    this.total_quantity,
    this.weight,
    this.zip_code,
    this.created_at,
    this.created_date,
    this.payment_status,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    bulk_discount_cost = json['bulk_discount_cost'];
    city = json['city'];
    email = json['email'];
    house = json['house'];
    order_id = json['order_id'];
    payment_method = json['payment_method'];
    phone = json['phone'];
    prefecture = json['prefecture'];
    redeemed_amount = json['redeemed_amount'];
    shipping_cost = json['shipping_cost'];
    shipping_discount_cost = json['shipping_discount_cost'];
    status = json['status'];
    sub_total = json['sub_total'];
    total_quantity = json['total_quantity'];
    weight = json['weight'];
    zip_code = json['zip_code'];
    created_at = json['created_at'];
    created_date = json['created_date'];
    payment_status = json['payment_status'];
  }
}
