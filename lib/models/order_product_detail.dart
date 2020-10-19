class OrderProductDetail {
  int id;
  bool combo;
  String customerReview;
  String image;
  String imageThumbnail;
  int orderAttributeId;
  String price;
  int productId;
  String productName;
  int quantity;
  bool reviewed;
  String slug;
  String soldBy;
  int subTotal;
  String variant;
  String variantTitle;
  String reviewId;

  OrderProductDetail(
      {this.id,
      this.combo,
      this.customerReview,
      this.image,
      this.imageThumbnail,
      this.orderAttributeId,
      this.price,
      this.productId,
      this.productName,
      this.quantity,
      this.reviewed,
      this.slug,
      this.soldBy,
      this.subTotal,
      this.variant,
      this.variantTitle,
      this.reviewId});

  OrderProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    combo = json['combo'];
    // customer_review = json['customer_review'];
    image = json['image'];
    imageThumbnail = json['image_thumbnail'];
    orderAttributeId = json['order_attribute_id'];
    price = json['price'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    reviewed = json['reviewed'];
    slug = json['slug'];
    soldBy = json['sold_by'];
    subTotal = json['sub_total'];
    variant = json['variant'];
    variant = json['variant_title'];
    reviewId = json['customer_review'] != null
        ? json['customer_review']["id"].toString()
        : '';
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
