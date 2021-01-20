import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context); Navigator.pop(context);
//      _scaffoldKey.currentState.showSnackBar(SnackBar(
//        content: Text("Successfully Logged In"),
//      ));
    });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to Ecapp ?',
                style: TextStyle(fontFamily: 'quicksand'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('registerPage');
                },
                child: Text(('Register'),
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

      showDialog(
          context: context,
          useRootNavigator: false,
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
                            tr("Logging in"),
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
      if (response.token != null) {
        _loginSuccess(context);
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
        Navigator.pop(context, true);
      }
    } else {
      setState(() => _validate = true);
    }
  }
}
