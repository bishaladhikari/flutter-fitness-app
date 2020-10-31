import '../links.dart';
import '../product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;
  final Links links;

  ProductResponse(this.products, this.error, this.links);

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products =
            (json["data"] as List).map((i) => new Product.fromJson(i)).toList(),
        links = Links.fromJson(json["links"]),
        error = null;

  ProductResponse.withError(String errorValue)
      : products = List(),
        links = Links(),
        error = errorValue;
}
