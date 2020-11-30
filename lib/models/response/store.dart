class Store {
  String storeName;
  String mobile;
  String email;
  String zipCode;
  String city;
  String address;
  String prefecture;
  String image;
  int productsCount;
  int comboProductsCount;

  Store(
      {this.storeName,
      this.mobile,
      this.email,
      this.zipCode,
      this.city,
      this.address,
      this.prefecture,
      this.image,
      this.productsCount,
      this.comboProductsCount});

  Store.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    mobile = json['mobile'];
    email = json['email'];
    zipCode = json['zip_code'];
    city = json['city'];
    address = json['address'];
    prefecture = json['prefecture'];
    image = json['image'];
    productsCount = json['products_count'];
    comboProductsCount = json['combo_products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.storeName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['zip_code'] = this.zipCode;
    data['city'] = this.city;
    data['address'] = this.address;
    data['prefecture'] = this.prefecture;
    data['image'] = this.image;
    data['products_count'] = this.productsCount;
    data['combo_products_count'] = this.comboProductsCount;
    return data;
  }
}
