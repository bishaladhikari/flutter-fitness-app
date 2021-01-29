import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/components/google_sign_in_button.dart';
import 'package:ecapp/components/apple_sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as platform;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/bloc/cart_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();

  bool _obscureText = true;
  bool _validate = false;

  AnimationController _controller;

  validate(context) async {
    showDialog(
        context: context,
//          barrierColor: Colors.white70,
        barrierDismissible: false,
        builder: (context) => Center(
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
                          tr("Signing up"),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  )),
            )));
    _scaffoldKey.currentState.removeCurrentSnackBar();

    FocusScope.of(context).requestFocus(new FocusNode());
    print("email" + emailController.text.toString());
    if (_formKey.currentState.validate()) {
      try {
        final response = await Repository().registerCustomer(
            fname: fnameController.text,
            lname: lnameController.text,
            email: emailController.text,
            mobile: mobileController.text,
            password: passwordController.text,
            cpassword: cpasswordController.text,
            referCode: referCodeController.text);
        print("RegisterRes:" + response.toString());
        _registerSuccess();
      } catch (error) {
        print("ErrorResponse:" + error.errorValue.toString());
        _showErrorMessage(context, error.errorValue);
      }
    } else {
      print("Not Validated");
      setState(() {
        _validate = true;
      });
    }
    Navigator.pop(context);
  }

  void _registerSuccess() {
    Navigator.pushReplacementNamed(context, 'emailConfirmPage',
        arguments: emailController.text);
  }

  void _showErrorMessage(context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(tr(message)),
      backgroundColor: Colors.redAccent,
    ));
    authBloc..drainStream();
  }

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
    fnameController.dispose();
    lnameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    cpasswordController.dispose();
    passwordController.dispose();
    referCodeController.dispose();
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required*";
    } else {
      return null;
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
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(NPrimaryColor),
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
          await authBloc.socialLogin('google', {"access_token": accessToken});
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
          clientId: 'com.rakurakubazzar',
//          '2K6Q8V56C3',
          redirectUri: Uri.parse(
            Repository().baseUrl + "/sign-in-with-apple/callback",
          ),
        ),
//        nonce: 'example-nonce',
//        state: 'example-state',
      );
      print("apple credential");
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
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(NPrimaryColor),
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
      LoginResponse response = await authBloc.socialLogin(
          'sign-in-with-apple', {"access_token": credential.identityToken});
      Navigator.pop(dialogContext);
      Navigator.pop(dialogContext, true);
      if (response.token != null) {
        // _loginSuccess(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.close),
          ),
          title: Text(tr('Create new Account'),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: _buildSignFormWidget(context));
  }

  Widget _buildSignFormWidget(context) {
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
                    controller: fnameController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.contact_mail),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: tr("First Name")),
                    validator: validatepass,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: lnameController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.contact_mail),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: tr("Last Name")),
                    validator: validatepass,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: mobileController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: tr("Mobile Number")),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                    ]),
                  ),
                  SizedBox(height: 10),
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
                      RequiredValidator(errorText: tr("Required*")),
                      EmailValidator(errorText: tr("Not A Valid Email")),
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
                  SizedBox(height: 10),
                  TextFormField(
                      controller: cpasswordController,
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
                          hintText: tr("Confirm Password")),
                      obscureText: _obscureText,
                      validator: (val) {
                        if (val.isEmpty) return tr('Required*');
                        if (val != passwordController.text)
                          return tr('Password does not Match');
                        return null;
                      }),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: referCodeController,
              style: TextStyle(color: Color(0xFF000000)),
              cursorColor: Color(0xFF9b9b9b),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.mail_outline),
                  border: OutlineInputBorder(),
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Referral Code (Optional)".tr()),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => validate(context),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                  "SIGN UP",
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
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('loginPage');
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
                child: Center(child: Text("Have an Account? Sign In")),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
