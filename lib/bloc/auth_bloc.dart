import 'dart:convert';

import 'package:ecapp/models/response/login_response.dart';
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
    print("constructor called");
    _loadSharedPreferences();
//    _changePreference.stream.listen(_setPref);
//    _changePreference.stream.listen(logout);
  }

  void drainStream() {
    _subject.value = null;
  }

  Future<void> _loadSharedPreferences() async {
    print("loaded sharedpref");
    pref = await SharedPreferences.getInstance();
    final user = pref.getString("user") != null
        ? User.fromJson(json.decode(pref.getString("user")))
        : User();
    print(pref.getString("user"));
    final token = pref.getString("token");
    _currentPreference.sink
        .add(PrefsData(user, token, token != null ? true : false));
  }

  login(credentials) async {
    try {
      LoginResponse response = await _repository.login(credentials);
      print("Response:" + response.toString());
      _subject.sink.add(response);
      if (response.token != null) {
        _setPref(response);
      }
    } catch (error) {
      print("Error:" + error.toString());
    }
  }

  _setPref(response) async {
    print("setting pref");
    pref = await SharedPreferences.getInstance();
    pref.setString("token", response.token);
    print(response.user.fullName);
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
  get isAuthenticated async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") != null ? true : false;
  }

//  get token async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    return json.decode(pref.getString("token"));
//  }
  void logout() async {
    print("logging out");
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
