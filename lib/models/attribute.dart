import 'package:ecapp/models/variant.dart';

import 'image.dart';

class Attribute {
  int id;
  bool availability;
  String productName;
  String sellingPrice;
  String discountPrice;
  int discountPercentage;
  List<Image> images;
  String soldBy;
  String weight;
  String unit;
  int actualQuantity;
  Variant variant;
  String slug;
  bool saved;

  Attribute(
      {this.id,
        this.availability,
        this.productName,
        this.sellingPrice,
        this.discountPrice,
        this.discountPercentage,
        this.images,
        this.soldBy,
        this.weight,
        this.unit,
        this.actualQuantity,
        this.variant,
        this.slug,
        this.saved});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availability = json['availability'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    if (json['images'] != null) {
      images = new List<Image>();
      json['images'].forEach((v) {
        images.add(new Image.fromJson(v));
      });
    }
    soldBy = json['sold_by'];
    weight = json['weight'];
    unit = json['unit'];
    actualQuantity = json['actual_quantity'];
    variant = Variant.fromJson(json['variant']);
    slug = json['slug'];
    saved = json['saved'];
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