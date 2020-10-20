import 'package:uuid/uuid.dart';

class Combo {
  int id;
  String title;
  int price;
  String soldBy;
  String storeSlug;
  bool availability;
  int actualQuantity;
  int actualPrice;
  String imageThumbnail;
  int priceDifference;
  String slug;
  int weight;
  String unit;
  bool saved;
  String heroTag;

  Combo(
      {this.id,
      this.title,
      this.price,
      this.soldBy,
      this.storeSlug,
      this.availability,
      this.actualQuantity,
      this.actualPrice,
      this.imageThumbnail,
      this.priceDifference,
      this.slug,
      this.weight,
      this.unit,
      this.heroTag,
      this.saved});

  Combo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    soldBy = json['sold_by'];
    storeSlug = json['store_slug'];
    availability = json['availability'];
    actualQuantity = json['actual_quantity'];
    actualPrice = json['actual_price'];
    imageThumbnail = json['image_thumbnail'];
    priceDifference = json['price_difference'];
    slug = json['slug'];
    weight = json['weight'];
    unit = json['unit'];
    saved = json['saved'];
    heroTag = Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['sold_by'] = this.soldBy;
    data['store_slug'] = this.storeSlug;
    data['availability'] = this.availability;
    data['actual_quantity'] = this.actualQuantity;
    data['actual_price'] = this.actualPrice;
    data['image_thumbnail'] = this.imageThumbnail;
    data['price_difference'] = this.priceDifference;
    data['slug'] = this.slug;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['saved'] = this.saved;
    
    return data;
  }
}
