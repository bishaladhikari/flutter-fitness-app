import '../links.dart';
import '../meta.dart';
import '../product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;
  final Links links;
  final Meta meta;

  ProductResponse(this.products, this.error, this.links, this.meta);

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products =
            (json["data"] as List).map((i) => new Product.fromJson(i)).toList(),
        links = Links.fromJson(json["links"]),
        meta = Meta.fromJson(json["meta"]),
        error = null;

  ProductResponse.withError(String errorValue)
      : products = List(),
        links = Links(),
        meta = Meta(),
        error = errorValue;
}
