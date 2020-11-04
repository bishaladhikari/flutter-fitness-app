class MessageResponse {
  final String error;
  final String message;

  MessageResponse(this.message, this.error);

  MessageResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        error = null;

  MessageResponse.withError(String errorValue)
      : error = errorValue,
        message = null;
}
