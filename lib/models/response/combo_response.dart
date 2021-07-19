import 'package:rakurakubazzar/models/meta.dart';
import '../combo.dart';

class ComboResponse {
  final List<Combo> combos;
  final String error;
  final Meta meta;

  ComboResponse(this.combos, this.error, this.meta);

  ComboResponse.fromJson(Map<String, dynamic> json)
      : combos =
            (json["data"] as List).map((i) => new Combo.fromJson(i)).toList(),
        meta = Meta.fromJson(json["meta"]),
        error = "";

  ComboResponse.withError(String errorValue)
      : combos = List(),
        meta = Meta(),
        error = errorValue;
}
