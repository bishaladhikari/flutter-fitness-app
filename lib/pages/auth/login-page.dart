import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ecapp/components/google_sign_in_button.dart';
import 'package:ecapp/components/apple_sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as platform;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//  var email = "actionbishal98130@gmail.com";
//  var password = "Password@123";

  bool _obscureText = true;
  bool _validate = false;
  String token;

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
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.close),
          ),
          title: Text('Sign In',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child: _buildLoginFormWidget(context)));
  }

  void _showErrorMessage(context, String message) {
    var msg =
        message == 'unauthenticated' ? 'Invalid Credentials' : tr(message);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.redAccent,
    ));
    authBloc..drainStream();
  }

  void _loginSuccess(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Navigator.pop(context);
//       Navigator.pop(context);
// //      _scaffoldKey.currentState.showSnackBar(SnackBar(
// //        content: Text("Successfully Logged In"),
// //      ));
//     });
  }

  Widget _buildLoginFormWidget(context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
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
                    RequiredValidator(errorText: "Email is required"),
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
                    RequiredValidator(errorText: "Password is required"),
//                      PatternValidator(
//                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
//                          errorText:
//                              'The Password must include a Lower case, a Upper Case, a digit, a symbol and more than 8 character')
                  ]),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('emailForgotPasswordPage');
            },
            child: Container(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: InkWell(
                      child: Text('Forget Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)))),
            ),
          ),
          GestureDetector(
            onTap: () => validateLogin(context),
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: NPrimaryColor,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                  child: Text(
                tr("SIGN IN"),
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            ),
          ),
          SizedBox(height: 16),
          GoogleSignInButton(
            handleSignIn: handleSignIn,
          ),
          SizedBox(height: 16),
          platform.Platform.isIOS
              ? AppleSignInButton(
                  handleSignIn: handleAppleSignIn,
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('New to rakurakubazzar?'),
                style: TextStyle(fontFamily: 'quicksand'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('registerPage');
                },
                child: Text(tr('Register'),
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          )
        ],
      ),
    );
  }

  validateLogin(context) async {
    if (_formKey.currentState.validate()) {
//      Navigator.of(context).push(
//        PageRouteBuilder(
//            pageBuilder: (context, _, __) => LoadingScreen(), opaque: false),
//      );

    BuildContext dialogContext;
      showDialog(
          context: context,
          useRootNavigator: false,
          barrierDismissible: false,
          builder: (context){
            dialogContext = context;
            return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    color: Colors.white,
                    width: 200,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator()),
                        SizedBox(
                          width: 20.0,
                        ),
                        Material(
                          child: Text(
                            tr("Logging in"),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    )),
              ));});
      _scaffoldKey.currentState.removeCurrentSnackBar();

      FocusScope.of(context).requestFocus(new FocusNode());
      LoginResponse response = await authBloc.login({
        "email": "${emailController.text}",
        "password": "${passwordController.text}"
      });
//      var stream = authBloc.subject.stream;
////        StreamSubscription<LoginResponse> subscription;
//      final subscription = stream.listen(null);
//      subscription.onData((response) {
//        if (response.error != null) _showErrorMessage(context, response.error);
//        if (response.token != null) _loginSuccess(context);
//        subscription.cancel();
//      });
      Navigator.pop(dialogContext, true);
      if (response.token != null) {
        // _loginSuccess(context);
        cartBloc.getCart();
        Fluttertoast.showToast(
            msg: tr("Login Success"),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: response.error == null ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _showErrorMessage(context, response.error);
      }
    } else {
      setState(() => _validate = true);
    }
  }

  Future<void> handleSignIn() async {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
//          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      var accessToken = googleAuth.accessToken;
      var idToken = googleAuth.idToken;
      print("google token " + accessToken.toString());
      BuildContext dialogContext;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          dialogContext = context;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.white,
                width: 200,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            NPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Material(
                      child: Text(
                        tr("Logging in"),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
      LoginResponse response =
          await Repository().socialLogin({"access_token": accessToken});
      Navigator.pop(dialogContext);
      Navigator.pop(dialogContext, true);
      if (response.token != null) {
        // _loginSuccess(context);
        cartBloc.getCart();
        Fluttertoast.showToast(
            msg: tr("Login Success"),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: response.error == null ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _showErrorMessage(context, response.error);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleAppleSignIn() async {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'jp.co.cvpro',
//          '2K6Q8V56C3',
          redirectUri: Uri.parse(
            Repository().baseUrl + "/apple/callback",
          ),
        ),
//        nonce: 'example-nonce',
//        state: 'example-state',
      );
      print("apple credential ");
      BuildContext dialogContext;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          dialogContext = context;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.white,
                width: 200,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            NPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Material(
                      child: Text(
                        tr("Logging in"),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
      LoginResponse response = await Repository()
          .appleLogin({"access_token": credential.identityToken});
      Navigator.pop(dialogContext, true);
      if (response.token != null) {
        // _loginSuccess(context);
        cartBloc.getCart();
        Fluttertoast.showToast(
            msg: tr("Login Success"),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: response.error == null ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _showErrorMessage(context, response.error);
      }
    } catch (error) {
      print(error);
    }
  }
}
