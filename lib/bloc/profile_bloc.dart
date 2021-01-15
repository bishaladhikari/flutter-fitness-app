import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/models/response/email_confirm_response.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProfileResponse> _subject =
      BehaviorSubject<ProfileResponse>();

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  userProfile() async {
    ProfileResponse response = await _repository.userProfile();
    _subject.add(response);
    if (response.error != null)
      Fluttertoast.showToast(
          msg: tr(response.error),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: response.error == null ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
