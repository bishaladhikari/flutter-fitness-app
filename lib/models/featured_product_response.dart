import 'product.dart';

class FeaturedProductResponse {
  final List<Product> products;
  final String error;

  FeaturedProductResponse(this.products, this.error);

  FeaturedProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json["data"] as List)
            .map((i) => new Product.fromJson(i))
            .toList(),
        error = "";

  FeaturedProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
