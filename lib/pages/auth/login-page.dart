import 'dart:async';
import 'dart:convert';

import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/widgets/widgets-index.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var email = "actionbishal98130@gmail.com";
  var password = "Password123";

  bool _obscureText = true;
  bool _validate = false;

  AnimationController _controller;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    authBloc..drainStream();
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.close),
          ),
          title: Text('Sign In!',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body:
//      StreamBuilder<LoginResponse>(
//        stream: authBloc.subject.stream,
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
//              WidgetsBinding.instance.addPostFrameCallback(
//                  (_) => _buildErrorWidget(context, snapshot.data.error));
//              return _buildLoginFormWidget(snapshot.data);
//            }
//          }
//          return _buildLoginFormWidget(snapshot.data);
//        },
//      ),
            _buildLoginFormWidget());
  }

  void _showErrorMessage(context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
    authBloc..drainStream();

//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text(message),
//    ));
  }

  void _loginSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
//      _scaffoldKey.currentState.showSnackBar(SnackBar(
//        content: Text("Successfully Logged In"),
//      ));
    });
  }

  Widget _buildLoginFormWidget() {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail_outline),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Email"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required*"),
                      EmailValidator(errorText: "Not A Valid Email"),
                    ]),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _toggle,
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Password"),
                    obscureText: _obscureText,
                    validator: MultiValidator([
                      PatternValidator(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          errorText:
                              'The Password must include a Lower case, a Upper Case, a digit, a symbol and more than 8 character')
                    ]),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('forgetpasswordPage');
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Forget Password?',
                      style: TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => validateLogin(context),
              child: Container(
//              padding: const EdgeInsets.all(5.0),
//              margin: const EdgeInsets.all(20.0),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        )),
                    Flexible(
                      flex: 1,
                      child: Text("or"),
                    ),
                    Expanded(
                        flex: 2,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        ))
                  ],
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
//                  Container(
//                    padding: const EdgeInsets.all(4.0),
//                    margin: const EdgeInsets.all(4.0),
//                    height: 50.0,
//                    width: (MediaQuery.of(context).size.width-28) / 2,
//                    decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: NPrimaryColor, width: 1.0),
//                          top: BorderSide(color: NPrimaryColor, width: 1.0),
//                          right: BorderSide(color: NPrimaryColor, width: 1.0),
//                          left: BorderSide(color: NPrimaryColor, width: 1.0),
//                        ),
//                        color: Color(0xFFFFFFFF),
//                        borderRadius: BorderRadius.circular(5.0)),
//                    child: Row(
//                      mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
//                        Image.asset(
//                          "assets/icons/fb.png",
//                          height: 25.0,
//                        ),
//                        Expanded(
//                            child: Text("Facebook",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 15.0))),
//                      ],
//                    ),
//                  ),
//                  Container(
//                    padding: const EdgeInsets.all(4.0),
//                    margin: const EdgeInsets.all(4.0),
//                    height: 50.0,
//                    width: (MediaQuery.of(context).size.width-28) / 2,
//                    decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: NPrimaryColor, width: 1.0),
//                          top: BorderSide(color: NPrimaryColor, width: 1.0),
//                          right: BorderSide(color: NPrimaryColor, width: 1.0),
//                          left: BorderSide(color: NPrimaryColor, width: 1.0),
//                        ),
//                        color: Color(0xFFFFFFFF),
//                        borderRadius: BorderRadius.circular(5.0)),
//                    child: Row(
//                      mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
//                        Image.asset(
//                          "assets/icons/google.png",
//                          height: 25.0,
//                        ),
//                        Expanded(
//                            child: Text("Google",
//                                textAlign: TextAlign.start,
//                                style: TextStyle(
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 15.0))),
//                      ],
//                    ),
//                  ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('registerPage');
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(10.0),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                      top: BorderSide(color: Colors.grey, width: 1.0),
                      right: BorderSide(color: Colors.grey, width: 1.0),
                      left: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(child: Text("New? Create an Account")),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  validateLogin(context) async {
    if (_formKey.currentState.validate()) {
      // print("email:" + emailController.text.toString());
      // print("password:" + passwordController.text.toString());
      LoginResponse response = await authBloc.login({
        "email": "${emailController.text.trim()}",
        "password": "${passwordController.text.trim()}"
      });
//      var stream = authBloc.subject.stream;
////        StreamSubscription<LoginResponse> subscription;
//      final subscription = stream.listen(null);
//      subscription.onData((response) {
//        if (response.error != null) _showErrorMessage(context, response.error);
//        if (response.token != null) _loginSuccess(context);
//        subscription.cancel();
//      });
      if (response.token != null)
        _loginSuccess(context);
      else
        _showErrorMessage(context, response.error);
    } else {
      setState(() => _validate = true);
    }
  }
}
