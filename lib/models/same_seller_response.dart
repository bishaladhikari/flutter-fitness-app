import 'product.dart';

class SameSellerResponse {
  final List<Product> products;
  final String error;

  SameSellerResponse(this.products, this.error);

  SameSellerResponse.fromJson(Map<String, dynamic> json)
      : products = (json["data"] as List)
            .map((i) => new Product.fromJson(i))
            .toList(),
        error = "";

  SameSellerResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
