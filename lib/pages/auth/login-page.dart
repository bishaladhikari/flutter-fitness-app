import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/login_response.dart';
import 'package:ecapp/widgets/widgets-index.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
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
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => ListView(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Sign In!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
          ),
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
                        validator: (emailValue) {
                          if (emailValue.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
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
                        validator: (emailValue) {
                          if (emailValue.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Forget Password?',
                        style: TextStyle(color: Colors.black, fontSize: 15.0)),
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
        ]),
      ),
    );
  }

  validateLogin(context) async {
    if (_formKey.currentState.validate()) {
      // print("email:" + emailController.text.toString());
      // print("password:" + passwordController.text.toString());
      try {
        await authBloc.login({
          "email": "${emailController.text.trim()}",
          "password": "${passwordController.text.trim()}"
        });
        var stream = authBloc.subject.stream;
        stream.listen((snapshot) {
          print("snapshot data");
          final snackbar = SnackBar(content: Text(snapshot.error));
          Scaffold.of(context).showSnackBar(snackbar);
          print("snapshot login error" + snapshot.error);
        }, onError: (snapshot) {
          print("snapshot error");
        });
//      StreamBuilder(
//        stream:authBloc.subject.stream,
//        builder:(context,snapshot){
//          final snackbar = SnackBar(content: Text('Yay! A SnackBar!'));
//           Scaffold.of(context).showSnackBar(snackbar);
//        }
//      );
      } catch (error) {
        print("here is login error" + error);
//        Scaffold.of(context).s
      }
    } else {
      setState(() => _validate = true);
    }
  }

}
