class ComboDetail {
  int id;
  String soldBy;
  String storeSlug;
  List<Attributes> attributes;
  String title;
  int price;
  bool availability;
  int actualPrice;
  String imageThumbnail;
  int priceDifference;
  int actualQuantity;
  Null avgRating;
  int zeroStarCount;
  int oneStarCount;
  int twoStarCount;
  int threeStarCount;
  int fourStarCount;
  int fiveStarCount;
  int totalReview;
  bool saved;
  List<AvailablePromotions> availablePromotions;
  int attributesCount;

  ComboDetail(
      {this.id,
      this.soldBy,
      this.storeSlug,
      this.attributes,
      this.title,
      this.price,
      this.availability,
      this.actualPrice,
      this.imageThumbnail,
      this.priceDifference,
      this.actualQuantity,
      this.avgRating,
      this.zeroStarCount,
      this.oneStarCount,
      this.twoStarCount,
      this.threeStarCount,
      this.fourStarCount,
      this.fiveStarCount,
      this.totalReview,
      this.saved,
      this.availablePromotions,
      this.attributesCount});

  ComboDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soldBy = json['sold_by'];
    storeSlug = json['store_slug'];
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    title = json['title'];
    price = json['price'];
    availability = json['availability'];
    actualPrice = json['actual_price'];
    imageThumbnail = json['image_thumbnail'];
    priceDifference = json['price_difference'];
    actualQuantity = json['actual_quantity'];
    avgRating = json['avg_rating'];
    zeroStarCount = json['zero_star_count'];
    oneStarCount = json['one_star_count'];
    twoStarCount = json['two_star_count'];
    threeStarCount = json['three_star_count'];
    fourStarCount = json['four_star_count'];
    fiveStarCount = json['five_star_count'];
    totalReview = json['total_review'];
    saved = json['saved'];
    if (json['available_promotions'] != null) {
      availablePromotions = new List<AvailablePromotions>();
      json['available_promotions'].forEach((v) {
        availablePromotions.add(new AvailablePromotions.fromJson(v));
      });
    }
    attributesCount = json['attributes_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sold_by'] = this.soldBy;
    data['store_slug'] = this.storeSlug;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['price'] = this.price;
    data['availability'] = this.availability;
    data['actual_price'] = this.actualPrice;
    data['image_thumbnail'] = this.imageThumbnail;
    data['price_difference'] = this.priceDifference;
    data['actual_quantity'] = this.actualQuantity;
    data['avg_rating'] = this.avgRating;
    data['zero_star_count'] = this.zeroStarCount;
    data['one_star_count'] = this.oneStarCount;
    data['two_star_count'] = this.twoStarCount;
    data['three_star_count'] = this.threeStarCount;
    data['four_star_count'] = this.fourStarCount;
    data['five_star_count'] = this.fiveStarCount;
    data['total_review'] = this.totalReview;
    data['saved'] = this.saved;
    if (this.availablePromotions != null) {
      data['available_promotions'] =
          this.availablePromotions.map((v) => v.toJson()).toList();
    }
    data['attributes_count'] = this.attributesCount;
    return data;
  }
}

class Attributes {
  int id;
  Category category;
  String productName;
  String productDescription;
  Brand brand;
  Null price;
  List<Images> images;
  String weight;
  String unit;
  String sku;
  int actualQuantity;
  String variantTitle;
  String variant;
  String slug;
  int quantity;
  List<Null> tags;

  Attributes(
      {this.id,
      this.category,
      this.productName,
      this.productDescription,
      this.brand,
      this.price,
      this.images,
      this.weight,
      this.unit,
      this.sku,
      this.actualQuantity,
      this.variantTitle,
      this.variant,
      this.slug,
      this.quantity,
      this.tags});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    productName = json['product_name'];
    productDescription = json['product_description'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    price = json['price'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    weight = json['weight'];
    unit = json['unit'];
    sku = json['sku'];
    actualQuantity = json['actual_quantity'];
    variantTitle = json['variant_title'];
    variant = json['variant'];
    slug = json['slug'];
    quantity = json['quantity'];
    if (json['tags'] != null) {
      tags = new List<Null>();
      json['tags'].forEach((v) {
        tags.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['sku'] = this.sku;
    data['actual_quantity'] = this.actualQuantity;
    data['variant_title'] = this.variantTitle;
    data['variant'] = this.variant;
    data['slug'] = this.slug;
    data['quantity'] = this.quantity;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String slug;
  String imageLink;
  String imageThumbnail;

  Category(
      {this.id, this.name, this.slug, this.imageLink, this.imageThumbnail});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imageLink = json['image_link'];
    imageThumbnail = json['image_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image_link'] = this.imageLink;
    data['image_thumbnail'] = this.imageThumbnail;
    return data;
  }
}

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

class Images {
  String image;
  String imageThumbnail;

  Images({this.image, this.imageThumbnail});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    imageThumbnail = json['image_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['image_thumbnail'] = this.imageThumbnail;
    return data;
  }
}

class AvailablePromotions {
  int id;
  String title;
  String type;
  int discount;
  String discountType;
  String areaType;
  int minimumRequirement;

  AvailablePromotions(
      {this.id,
      this.title,
      this.type,
      this.discount,
      this.discountType,
      this.areaType,
      this.minimumRequirement});

  AvailablePromotions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    areaType = json['area_type'];
    minimumRequirement = json['minimum_requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['area_type'] = this.areaType;
    data['minimum_requirement'] = this.minimumRequirement;
    return data;
  }
}