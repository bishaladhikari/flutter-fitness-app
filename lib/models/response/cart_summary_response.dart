
import 'package:rakurakubazzar/models/cart_summary.dart';

class CartSummaryResponse {
  CartSummary cartSummary;
  final String error;

  CartSummaryResponse(this.cartSummary, this.error);

  CartSummaryResponse.fromJson(Map<String, dynamic> json)
      : cartSummary = CartSummary.fromJson(json),
        error = null;

  CartSummaryResponse.withError(String errorValue)
      : cartSummary = null,
        error = errorValue;
}
