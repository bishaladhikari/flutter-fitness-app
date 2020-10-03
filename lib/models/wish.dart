import 'attribute.dart';
import 'combo.dart';

class Wish {
  int id;
  int quantity;
  Attribute attribute;
  Combo combo;
  String productName;
  String imageThumbnail;
  String price;

  Wish({this.id, this.quantity, this.attribute, this.combo}) {
    productName = this.attribute!=null?this.attribute.productName:this.combo.title;
    imageThumbnail = this.attribute!=null?this.attribute.imageThumbnail:this.combo.imageThumbnail;
    price = this.attribute!=null?this.attribute.sellingPrice:this.combo.price;
  }

  Wish.fromJson(Map<String, dynamic> json) {
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