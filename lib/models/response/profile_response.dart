import 'package:rakurakubazzar/models/profile.dart';

class ProfileResponse {
  final Profile profile;
  final String error;

  ProfileResponse(this.profile, this.error);

  ProfileResponse.fromJson(Map<String, dynamic> json)
      : profile = Profile.fromJson(json["data"]),
        error = null;

  ProfileResponse.withError(String errorValue)
      : profile = Profile(),
        error = errorValue;
}
