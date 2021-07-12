import 'package:rakurakubazzar/models/user.dart';

class LoginResponse {
  final String error;
  final String token;
  final user;
  final avatar;

  LoginResponse(this.user, this.token, this.error, this.avatar);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json["token"],
        user = User.fromJson(json["user"]),
        avatar = json["avatar"] ?? null,
        error = null;

  LoginResponse.withError(String errorValue)
      : error = errorValue,
        user = null,
        avatar = null,
        token = null;
}
