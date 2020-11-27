class LoyaltyPointResponse {
  final String error;
  final String bonusPoint;
  final double cashOnDeliveryCharge;
  final String points;
  final double rate;

//  final setting;

  LoyaltyPointResponse(this.points, this.bonusPoint,this.cashOnDeliveryCharge, this.error, this.rate);

  LoyaltyPointResponse.fromJson(Map<String, dynamic> json)
      : bonusPoint = json["bonus_point"] != null ? json["bonus_point"] : "0",
        points = json["points"] != null ? json["points"] : "0",
        cashOnDeliveryCharge = json["cash_on_delivery_charge"],
        rate = json["setting"]["amount_value"] / json["setting"]["points"],
//        setting = json["setting"],
        error = null;

  LoyaltyPointResponse.withError(String errorValue)
      : error = errorValue,
        bonusPoint = null,
        cashOnDeliveryCharge = 0.0,
        points = null,
        rate = null;
//        setting = null;
}
