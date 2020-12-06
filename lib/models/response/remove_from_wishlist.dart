class RemoveFromWishlistResponse {
  final String error;
  final String message;

  RemoveFromWishlistResponse(this.error, this.message);

  RemoveFromWishlistResponse.fromJson(Map<String, dynamic> json)
      : error = null,
        message = json["message"];

  RemoveFromWishlistResponse.withError(String errorValue)
      : error = errorValue,
        message = null;
}
