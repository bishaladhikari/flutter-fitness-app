import 'package:ecapp/models/profile.dart';

class ProfileResponse {
  final String error;
  final profile;

  ProfileResponse(this.profile, this.error);

  ProfileResponse.fromJson(Map<String, dynamic> json)
      : profile = Profile.fromJson(json["data"]),
        error = null;

  ProfileResponse.withError(String errorValue)
      : error = errorValue,
        profile = Profile();
}
