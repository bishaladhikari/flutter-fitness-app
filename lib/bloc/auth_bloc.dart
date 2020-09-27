import 'dart:convert';

import 'package:ecapp/models/login_response.dart';
import 'package:ecapp/models/user.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final Repository _repository = Repository();
  SharedPreferences pref;
  final BehaviorSubject<LoginResponse> _subject =
      BehaviorSubject<LoginResponse>();
//  final BehaviorSubject<bool> _isLoggedIn = BehaviorSubject<bool>();

  login(credentials) async {
    LoginResponse response = await _repository.login(credentials);
    _subject.sink.add(response);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", response.token);
    pref.setString("user", response.user);
    print(response.user);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;

  get isLoggedIn async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") != null ? true : false;
  }

  get token async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }
  get user async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return User.fromJson(json.decode(pref.getString("user")));
  }
}

final authBloc = AuthBloc();
