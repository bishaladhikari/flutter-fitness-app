class OrderProductDetail {
  int id;
  String combo;
  String customer_review;
  String image;
  String image_thumbnail;
  int order_attribute_id;
  String price;
  int product_id;
  String product_name;
  int quantity;
  bool reviewed;
  String slug;
  String sold_by;
  int sub_total;
  String variant;
  String variant_title;


  OrderProductDetail({
    this.id,
    this.combo,
    this.customer_review,
    this.image,
    this.image_thumbnail,
    this.order_attribute_id,
    this.price,
    this.product_id,
    this.product_name,
    this.quantity,
    this.reviewed,
    this.slug,
    this.sold_by,
    this.sub_total,
    this.variant,
    this.variant_title
  });

  OrderProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    combo = json['combo'];
    customer_review = json['customer_review'];
    image = json['image'];
    image_thumbnail = json['image_thumbnail'];
    order_attribute_id = json['order_attribute_id'];
    price = json['price'];
    product_id = json['product_id'];
    product_name = json['product_name'];
    quantity = json['quantity'];
    reviewed = json['reviewed'];
    slug = json['slug'];
    sold_by = json['sold_by'];
    sub_total = json['sub_total'];
    variant = json['variant'];
    variant_title = json['variant_title'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['combo'] = this.combo;
  //   data['customer_review'] = this.customer_review;
  //   data['image'] = this.image;
  //   data['image_thumbnail'] = this.image_thumbnail;
  //   data['order_attribute_id'] = this.order_attribute_id;
  //   data['product_id'] = this.product_id;
  //   data['product_name'] = this.product_name;
  //   data['quantity'] = this.quantity;
  //   data['reviewed'] = this.reviewed;
  //   data['slug'] = this.slug;
  //   data['sold_by'] = this.sold_by;
  //   data['sub_total'] = this.sub_total;
  //   data['variant'] = this.variant;
  //   data['variant_title'] = this.variant_title;
  //   return data;
  // }
}
