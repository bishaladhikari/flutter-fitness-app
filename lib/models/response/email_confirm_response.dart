class EmailConfirmResponse {
  final String error;
  final String message;

  EmailConfirmResponse(this.message, this.error);

  EmailConfirmResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        error = null;

  EmailConfirmResponse.withError(String errorValue)
      : error = errorValue,
        message = null;
}
