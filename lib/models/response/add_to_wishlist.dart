
class AddToWishlistResponse {
  final String error;

  AddToWishlistResponse(this.error);

  AddToWishlistResponse.fromJson(Map<String, dynamic> json)
      : error = null;

  AddToWishlistResponse.withError(String errorValue)
      : error = errorValue;
}
