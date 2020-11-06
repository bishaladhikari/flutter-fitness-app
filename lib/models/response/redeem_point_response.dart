class RedeemPointResponse {
  final String error;
  final int amountValue;
  final String message;

  RedeemPointResponse(this.amountValue, this.message, this.error);

  RedeemPointResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        amountValue = json["amount_value"],
        error = null;

  RedeemPointResponse.withError(String errorValue)
      : error = errorValue,
        message = null,
        amountValue = null;
}
