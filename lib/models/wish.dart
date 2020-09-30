class Wish {
  int id;
  String productName;
  String sellingPrice;
  String discountPrice;
  int discountPercentage;
  String image;
  String imageThumbnail;
  String soldBy;
  String weight;
  String unit;
  String variant;
  String variantTitle;
  String slug;
  bool saved;

  Wish(
      {this.id,
        this.productName,
        this.sellingPrice,
        this.discountPrice,
        this.discountPercentage,
        this.image,
        this.imageThumbnail,
        this.soldBy,
        this.weight,
        this.unit,
        this.variant,
        this.variantTitle,
        this.slug,
        this.saved});

  Wish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    image = json['image'];
    imageThumbnail = json['image_thumbnail'];
    soldBy = json['sold_by'];
    weight = json['weight'];
    unit = json['unit'];
    variant = json['variant'];
    variantTitle = json['variant_title'];
    slug = json['slug'];
    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['selling_price'] = this.sellingPrice;
    data['discount_price'] = this.discountPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['image'] = this.image;
    data['image_thumbnail'] = this.imageThumbnail;
    data['sold_by'] = this.soldBy;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['variant'] = this.variant;
    data['variant_title'] = this.variantTitle;
    data['slug'] = this.slug;
    data['saved'] = this.saved;
    return data;
  }
}