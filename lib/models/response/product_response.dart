import '../product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;

  ProductResponse(this.products, this.error);

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json["data"] as List)
            .map((i) => new Product.fromJson(i))
            .toList(),
        error = null;

  ProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}