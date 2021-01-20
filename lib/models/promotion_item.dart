class PromotionItem {
  int id;
  int discount;
  String areaType;
  String discountType;
  int minimumRequirement;
  String title;
  String type;

  PromotionItem(
      {this.id,
        this.discount,
        this.areaType,
        this.discountType,
        this.minimumRequirement,
        this.title,
        this.type
      });

  PromotionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = json['discount'];
    areaType = json['quantity'];
    discountType = json['discount_type'];
    minimumRequirement = json['minimum_requirement'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount'] = this.discount;
    data['area_type'] = this.areaType;
    data['discount_type'] = this.discountType;
    data['minimum_requirement'] = this.minimumRequirement;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
