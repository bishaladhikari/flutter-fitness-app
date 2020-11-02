import 'package:uuid/uuid.dart';

import 'attribute.dart';
import 'combo.dart';

class CartItem {
  int id;
  int quantity;
  Attribute attribute;
  Combo combo;
  String price;
  bool availability;
  String heroTag;

  CartItem(
      {this.id,
      this.quantity,
      this.attribute,
      this.combo,
      this.price,
      this.heroTag});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    combo = json['combo'] != null ? new Combo.fromJson(json['combo']) : null;
    price = attribute != null
        ? attribute.price.toString()
        : combo.price.toString();
    availability =
        attribute != null ? attribute.availability : combo.availability;
    heroTag = Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.attribute != null) {
      data['attribute'] = this.attribute.toJson();
    }
    if (this.combo != null) {
      data['combo'] = this.combo.toJson();
    }
    return data;
  }

  get name {
    return attribute != null ? attribute.productName : combo.title;
  }

  get imageThumbnail {
    return attribute != null ? attribute.imageThumbnail : combo.imageThumbnail;
  }
}
