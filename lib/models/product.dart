import 'package:uuid/uuid.dart';

import 'category.dart';

class Product {
  int id;
  String name;
  Category category;
  int discountPercentage;
  bool availability;
  String sellingPrice;
  String discountPrice;
  String image;
  String imageThumbnail;
  String soldBy;
  String weight;
  String unit;
  String variant;
  String variantTitle;
  int actualQuantity;
  String slug;
  double avgRating;
  bool saved;
  int attributeId;
  String heroTag;
  Product productDetail;
  int reviewCount;

  Product(
      {this.id,
      this.name,
      this.category,
      this.discountPercentage,
      this.availability,
      this.sellingPrice,
      this.discountPrice,
      this.image,
      this.imageThumbnail,
      this.soldBy,
      this.weight,
      this.unit,
      this.variant,
      this.variantTitle,
      this.actualQuantity,
      this.slug,
      this.avgRating,
      this.saved,
      this.heroTag,
      this.attributeId,
      this.reviewCount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    discountPercentage = json['discount_percentage'];
    availability = json['availability'];
    sellingPrice = json['selling_price'].toString();
    discountPrice =
        json['discount_price'] != null ? json['discount_price'].toString() : null;
    image = json['image'];
    imageThumbnail = json['image_thumbnail'];
    soldBy = json['sold_by'];
    weight = json['weight'].toString();
    unit = json['unit'];
    variant = json['variant'];
    variantTitle = json['variant_title'];
    actualQuantity = json['actual_quantity'];
    slug = json['slug'];
    avgRating =
        json['avg_rating'] != null ? json['avg_rating'].toDouble() : 0.0;
    saved = json['saved'];
    attributeId = json['attribute_id'];
    reviewCount = json['total_review'];
    heroTag = Uuid().v4();
  }
}
