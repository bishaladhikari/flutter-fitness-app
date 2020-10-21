import 'attribute.dart';
import 'combo.dart';

class CartItem {
  int id;
  int quantity;
  Attribute attribute;
  Combo combo;
  String price;
  bool availability;

  CartItem({this.id, this.quantity, this.attribute, this.combo, this.price});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    combo = json['combo'] != null ? new Combo.fromJson(json['combo']) : null;
    price = attribute != null
        ? attribute.discountPrice.toString()
        : combo.price.toString();
    availability =
        attribute != null ? attribute.availability : combo.availability;
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
