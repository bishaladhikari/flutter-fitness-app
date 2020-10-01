import '../product_detail.dart';

class ProductDetailResponse {
  final ProductDetail productDetail;
  final String error;

  ProductDetailResponse(this.productDetail, this.error);

  ProductDetailResponse.fromJson(Map<String, dynamic> json)
      : productDetail = ProductDetail.fromJson(json["data"]),
        error = "";

  ProductDetailResponse.withError(String errorValue)
      : productDetail = ProductDetail(),
        error = errorValue;
}
