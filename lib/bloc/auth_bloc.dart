import 'dart:convert';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/models/response/login_response.dart';
import 'package:fitnessive/models/response/email_confirm_response.dart';
import 'package:fitnessive/models/user.dart';
import 'package:fitnessive/repository/repository.dart';
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
    final avatar = pref.getString("avatar");
    _currentPreference.sink
        .add(PrefsData(user, token, token != null ? true : false, avatar));
  }

  login(credentials) async {
    LoginResponse response = await _repository.login(credentials);
    _subject.sink.add(response);
    if (response.token != null) {
      _setPref(response);
    }
    return response;
  }

  socialLogin(provider, params) async {
    LoginResponse response = await _repository.socialLogin(provider, params);
    _subject.sink.add(response);
    if (response.token != null) {
      _setPref(response);
      cartBloc.getCart();
    }
    return response;
  }

  appleLogin(params) async {
    LoginResponse response = await _repository.appleLogin(params);
    _subject.sink.add(response);
    if (response.token != null) {
      _setPref(response);
    }
    return response;
  }

  emailForgotPassword(email) async {
    EmailConfirmResponse response =
        await _repository.emailForgotPassword(email);
    return response;
  }

  forgotPasswordUpdate(params) async {
    EmailConfirmResponse response =
        await _repository.forgotPasswordUpdate(params);
    return response;
  }

  confirmEmailOTP(params) async {
    EmailConfirmResponse response = await _repository.confirmEmailOTP(params);
    return response;
  }

  resendOTPCode(email) async {
    EmailConfirmResponse response = await _repository.resendOTPCode(email);
    return response;
  }

  _setPref(response) async {
    pref = await SharedPreferences.getInstance();
    pref.setString("token", response.token);
    pref.setString("user", json.encode(response.user.toJson()));
    pref.setString("avatar", response.avatar);
    pref.commit();
    _currentPreference.sink.add(PrefsData(response.user, response.token,
        response.token != null ? true : false, response.avatar));
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
    pref.setString("avatar", null);
    User user;
    _currentPreference.sink.add(PrefsData(user, "", false, null));
    cartBloc.drainStream();
  }
}

final authBloc = AuthBloc();

class PrefsData {
  final User user;
  final String token;
  final avatar;
  final bool isAuthenticated;

  PrefsData(this.user, this.token, this.isAuthenticated, this.avatar);
}
