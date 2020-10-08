import '../combo.dart';
import '../product.dart';

class ComboResponse {
  final List<Combo> products;
  final String error;

  ComboResponse(this.products, this.error);

  ComboResponse.fromJson(Map<String, dynamic> json)
      : products = (json["data"] as List)
            .map((i) => new Combo.fromJson(i))
            .toList(),
        error = "";

  ComboResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
