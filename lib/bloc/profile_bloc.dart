import 'package:ecapp/models/response/email_confirm_response.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProfileResponse> _subject =
      BehaviorSubject<ProfileResponse>();

  userProfile() async {
    ProfileResponse response = await _repository.userProfile();
    _subject.add(response);
    return response;
  }

  userProfileUpdate(params) async {
    ProfileResponse response = await _repository.userProfileUpdate(params);
    return response;
  }

  userPasswordUpdate(params) async {
    EmailConfirmResponse response =
        await _repository.userPasswordUpdate(params);
    return response;
  }

  BehaviorSubject<ProfileResponse> get subject => _subject;
}

final profileBloc = ProfileBloc();
