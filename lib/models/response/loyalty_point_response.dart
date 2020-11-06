class LoyaltyPointResponse {
  final String error;
  final String bonusPoint;
  final int points;
  final setting;

  LoyaltyPointResponse(this.setting, this.points, this.bonusPoint, this.error);

  LoyaltyPointResponse.fromJson(Map<String, dynamic> json)
      : bonusPoint = json["bonus_point"],
        points = json["points"],
        setting = json["setting"],
        error = null;

  LoyaltyPointResponse.withError(String errorValue)
      : error = errorValue,
        bonusPoint = null,
        points = null,
        setting = null;
}
