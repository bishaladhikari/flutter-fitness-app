import 'package:ecapp/models/cart_item.dart';

class Cart {
  int id;
  String soldBy;
  String storeSlug;
  List<CartItem> items;
//  List<Null> promotions;

  Cart({this.id, this.soldBy, this.storeSlug, this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soldBy = json['sold_by'];
    storeSlug = json['store_slug'];
    if (json['items'] != null) {
      items = new List<CartItem>();
      json['items'].forEach((v) {
        items.add(new CartItem.fromJson(v));
      });
    }
//    if (json['promotions'] != null) {
//      promotions = new List<Null>();
//      json['promotions'].forEach((v) {
//        promotions.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sold_by'] = this.soldBy;
    data['store_slug'] = this.storeSlug;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
//    if (this.promotions != null) {
//      data['promotions'] = this.promotions.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

