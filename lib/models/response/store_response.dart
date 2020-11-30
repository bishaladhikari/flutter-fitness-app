import 'package:ecapp/models/response/store.dart';

class StoreResponse {
  Store store;
  final String error;

  StoreResponse(this.store, this.error);

  StoreResponse.fromJson(Map<String, dynamic> json)
      : store = Store.fromJson(json["data"]),
        error = null;

  StoreResponse.withError(String errorValue)
      : store = Store(),
        error = errorValue;
}
