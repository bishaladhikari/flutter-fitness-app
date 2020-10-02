import 'product.dart';

class RelatedProductResponse {
  final List<Product> products;
  final String error;

  RelatedProductResponse(this.products, this.error);

  RelatedProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json["data"] as List)
            .map((i) => new Product.fromJson(i))
            .toList(),
        error = "";

  RelatedProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
