import 'package:rakurakubazzar/models/user.dart';

class RegisterResponse {
  final String error;
  final user;

  RegisterResponse(this.user, this.error);

  RegisterResponse.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]),
        error = null;

  RegisterResponse.withError(String errorValue)
      : error = errorValue,
        user = null;
}
