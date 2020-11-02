import '../combo.dart';

class ComboResponse {
  final List<Combo> combos;
  final String error;

  ComboResponse(this.combos, this.error);

  ComboResponse.fromJson(Map<String, dynamic> json)
      : combos =
            (json["data"] as List).map((i) => new Combo.fromJson(i)).toList(),
        error = "";

  ComboResponse.withError(String errorValue)
      : combos = List(),
        error = errorValue;
}
