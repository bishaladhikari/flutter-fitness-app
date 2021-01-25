import '../address.dart';

class DefaultAddressResponse {
  Address address;
  final error;

  DefaultAddressResponse(this.address,this.error);

  DefaultAddressResponse.fromJson(Map<String, dynamic> json)
      : address = Address.fromJson(json["data"]),
        error = null;

  DefaultAddressResponse.withError(String errorValue)
      : address = Address(),
        error = errorValue;
}
