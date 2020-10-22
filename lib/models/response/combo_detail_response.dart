
import '../combo_detail.dart';

class ComboDetailResponse {
  ComboDetail comboDetail;
  final String error;

  ComboDetailResponse(this.comboDetail, this.error);

  ComboDetailResponse.fromJson(Map<String, dynamic> json)
      : comboDetail = ComboDetail.fromJson(json["data"]),
        error = null;

  ComboDetailResponse.withError(String errorValue)
      : comboDetail = ComboDetail(),
        error = errorValue;
}
