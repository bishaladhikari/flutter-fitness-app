class Brand {
  int id;
  String name;
  String slug;
  int productsCount;

  Brand({this.id, this.name, this.slug, this.productsCount});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    productsCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['products_count'] = this.productsCount;
    return data;
  }
}