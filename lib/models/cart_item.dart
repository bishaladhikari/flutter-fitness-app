import 'attribute.dart';
import 'combo.dart';

class CartItem {
  int id;
  int quantity;
  Attribute attribute;
  Combo combo;

  CartItem({this.id, this.quantity, this.attribute, this.combo});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    combo = json['combo'] != null ? new Combo.fromJson(json['combo']) : null;
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
}
