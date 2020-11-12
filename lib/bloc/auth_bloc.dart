import 'dart:convert';

import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/models/response/message_response.dart';
import 'package:ecapp/models/user.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final Repository _repository = Repository();
  SharedPreferences pref;
  final BehaviorSubject<LoginResponse> _subject =
      BehaviorSubject<LoginResponse>();

  final BehaviorSubject<PrefsData> _currentPreference =
      BehaviorSubject<PrefsData>();

//  Function(PrefsData) get changePrefs => _changePreference.sink.add;
  AuthBloc() {
    _loadSharedPreferences();
//    _changePreference.stream.listen(_setPref);
//    _changePreference.stream.listen(logout);
  }

  void drainStream() {
    _subject.value = null;
  }

  Future<void> _loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    final user = pref.getString("user") != null
        ? User.fromJson(json.decode(pref.getString("user")))
        : User();
    final token = pref.getString("token");
    _currentPreference.sink
        .add(PrefsData(user, token, token != null ? true : false));
  }

  login(credentials) async {
    LoginResponse response = await _repository.login(credentials);
    _subject.sink.add(response);
    if (response.token != null) {
      _setPref(response);
    }
    return response;
  }

  emailForgotPassword(email) async {
    MessageResponse response = await _repository.emailForgotPassword(email);
    return response;
  }

  forgotPasswordUpdate(params) async {
    MessageResponse response = await _repository.forgotPasswordUpdate(params);
    return response;
  }

  confirmEmailOTP(params) async {
    MessageResponse response = await _repository.confirmEmailOTP(params);
    return response;
  }

  resendOTPCode(email) async {
    MessageResponse response = await _repository.resendOTPCode(email);
    return response;
  }

  _setPref(response) async {
    pref = await SharedPreferences.getInstance();
    pref.setString("token", response.token);
    pref.setString("user", json.encode(response.user.toJson()));
    pref.commit();
    _currentPreference.sink.add(PrefsData(
        response.user, response.token, response.token != null ? true : false));
  }

  dispose() {
    _subject.close();
    _currentPreference?.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;

  BehaviorSubject<PrefsData> get currentPreference => _currentPreference;

//  BehaviorSubject<User> get currentUser => _currentUser;
  Stream<PrefsData> get preference => currentPreference.stream;

//
//  Future<User> get currentUser async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    print(User.fromJson(json.decode(pref.getString("user"))));
//    return User.fromJson(json.decode(pref.getString("user")));
//  }
  Future<bool> isAuthenticated() async {
    // check if already in stream
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") != null ? true : false;
  }

  get user async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user") != null
        ? User.fromJson(json.decode(pref.getString("user")))
        : User();
  }

//  get token async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    return json.decode(pref.getString("token"));
//  }
  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", null);
    pref.setString("user", null);
    User user;
    _currentPreference.sink.add(PrefsData(user, "", false));
  }
}

final authBloc = AuthBloc();

class PrefsData {
  final User user;
  final String token;
  final bool isAuthenticated;

  PrefsData(this.user, this.token, this.isAuthenticated);
}
