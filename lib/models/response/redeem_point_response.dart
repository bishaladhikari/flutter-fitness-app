class RedeemPointResponse {
  final String error;
  final int amountValue;
  final int cashOnDeliveryCharge;
  final String message;

  RedeemPointResponse(this.amountValue,this.cashOnDeliveryCharge, this.message, this.error);

  RedeemPointResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        amountValue = json["amount_value"],
        cashOnDeliveryCharge = json["cash_on_delivery_charge"],
        error = null;

  RedeemPointResponse.withError(String errorValue)
      : error = errorValue,
        message = null,
        cashOnDeliveryCharge = null,
        amountValue = null;
}
