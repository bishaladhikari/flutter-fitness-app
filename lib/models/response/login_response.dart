import 'package:ecapp/models/user.dart';

class LoginResponse {
  final String error;
  final String token;
  final user;

  LoginResponse(this.user, this.token, this.error);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json["token"],
        user = User.fromJson(json["user"]),
        error = "";

  LoginResponse.withError(String errorValue)
      : error = errorValue,
        user = "",
        token = "";
}
