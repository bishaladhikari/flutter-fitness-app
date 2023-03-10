import 'brand.dart';
import 'attribute.dart';
import 'category.dart';
import 'variant.dart';

class ProductDetail {
  int id;
  Category category;
  Brand brand;
  String soldBy;
  String storeSlug;
  String variantTitle;
  List<Variant> variants;
  List<Attribute> attributes;
  List<String> tags;
  String name;
  String description;
  String slug;
  bool saved;
  Attribute selectedAttribute;
  Variant selectedVariant;
  double avgRating;
  int zeroStarCount;
  int oneStarCount;
  int twoStarCount;
  int threeStarCount;
  int fourStarCount;
  int fiveStarCount;
  int totalReview;
  int reviewCount;

  ProductDetail(
      {this.id,
      this.category,
      this.brand,
      this.soldBy,
      this.storeSlug,
      this.variantTitle,
      this.variants,
      this.attributes,
      this.tags,
      this.name,
      this.description,
      this.slug,
      this.saved,
      this.selectedAttribute,
      this.selectedVariant,
      this.avgRating,
      this.zeroStarCount,
      this.oneStarCount,
      this.twoStarCount,
      this.threeStarCount,
      this.fourStarCount,
      this.fiveStarCount,
      this.totalReview,
      this.reviewCount});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    soldBy = json['sold_by'];
    storeSlug = json['store_slug'];
    variantTitle = json['variant_title'];
    if (json['variants'] != null) {
      variants = new List<Variant>();
      json['variants'].forEach((v) {
        variants.add(new Variant.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = new List<Attribute>();
      json['attributes'].forEach((v) {
        attributes.add(new Attribute.fromJson(v));
      });
    }
    tags = json['tags'].cast<String>();
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    saved = json['saved'];
    avgRating =
        json['avg_rating'] != null ? json['avg_rating'].toDouble() : 0.0;
    zeroStarCount = json['zero_star_count'];
    oneStarCount = json['one_star_count'];
    twoStarCount = json['two_star_count'];
    threeStarCount = json['three_star_count'];
    fourStarCount = json['four_star_count'];
    fiveStarCount = json['five_star_count'];
    totalReview = json['total_review'];
    reviewCount = json['total_review'];
    selectedAttribute = attributes[0];
    selectedVariant = selectedAttribute.variant;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['sold_by'] = this.soldBy;
    data['store_slug'] = this.storeSlug;
    data['variant_title'] = this.variantTitle;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['tags'] = this.tags;
    data['name'] = this.name;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['saved'] = this.saved;
    return data;
  }
}
