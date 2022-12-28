import 'package:fitnessive/models/variant.dart';

import 'attribute_image.dart';

class Attribute {
  int id;
  bool availability;
  String productName;
  String sellingPrice;
  String discountPrice;
  int discountPercentage;
  List<AttributeImage> images;
  String imageThumbnail;
  String soldBy;
  String weight;
  String unit;
  int actualQuantity;
  Variant variant;
  String variantTitle;
  String slug;
  bool saved;
  String price;

  Attribute(
      {this.id,
      this.availability,
      this.productName,
      this.sellingPrice,
      this.discountPrice,
      this.discountPercentage,
      this.images,
      String imageThumbnail,
      this.soldBy,
      this.weight,
      this.unit,
      this.actualQuantity,
      this.variant,
      this.variantTitle,
      this.slug,
      this.saved});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availability = json['availability'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'].toString();
    discountPrice =
        json['discount_price'] != null ? json['discount_price'].toString() : null;
    discountPercentage = json['discount_percentage'];
    if (json['images'] != null) {
      images = new List<AttributeImage>();
      json['images'].forEach((v) {
        images.add(new AttributeImage.fromJson(v));
      });
    }
    imageThumbnail = json['image_thumbnail'] ?? null;
    soldBy = json['sold_by'];
    weight = json['weight'].toString();
    unit = json['unit'];
    actualQuantity = json['actual_quantity'];
    variant =
        json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    slug = json['slug'];
    variantTitle = json['variant_title'];
    saved = json['saved'];
    price = discountPrice != null ? discountPrice : sellingPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['availability'] = this.availability;
    data['product_name'] = this.productName;
    data['selling_price'] = this.sellingPrice;
    data['discount_price'] = this.discountPrice;
    data['discount_percentage'] = this.discountPercentage;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['sold_by'] = this.soldBy;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['actual_quantity'] = this.actualQuantity;
    data['variant'] = this.variant;
    data['slug'] = this.slug;
    data['saved'] = this.saved;
    return data;
  }
}
