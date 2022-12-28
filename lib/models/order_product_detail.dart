import 'package:fitnessive/models/customer_review.dart';
import 'package:uuid/uuid.dart';

class OrderProductDetail {
  int id;
  bool combo;
  CustomerReview customerReview;
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
  var subTotal;
  String variant;
  String variantTitle;
  String reviewId;

  get heroTag => Uuid().v4();

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
    customerReview = json['customer_review'] != null ? CustomerReview.fromJson(json['customer_review']) : null;
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
}
