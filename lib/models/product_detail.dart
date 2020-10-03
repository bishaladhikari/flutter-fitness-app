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

  ProductDetail({
    this.id,
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
    this.selectedVariant
  });

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
    ;
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
