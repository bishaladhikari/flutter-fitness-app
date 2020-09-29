import 'package:ecapp/constants.dart';
import 'package:ecapp/widgets/widgets-index.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NPrimaryColor,
        elevation: 0.0,
      ),
      body: ListView(children: [
        Container(
          height: 200,
          color: NPrimaryColor,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "E-Capp",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
                Text("Shopping Made Easy!",
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Sign Up',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ),
        ),
        Row(
          children: [
            Expanded(child: AppTextField(hintText: "First Name")),
            Expanded(child: AppTextField(hintText: "Last Name")),
          ],
        ),
        AppTextField(hintText: "Email Address"),
        AppTextField(hintText: "Password"),
        Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(10.0),
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: NPrimaryColor, borderRadius: BorderRadius.circular(5.0)),
          child: Center(
              child: Text("Create an Account",
                  style: TextStyle(fontSize: 14, color: Colors.white))),
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
            Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(4.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2.1,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: NPrimaryColor, width: 1.0),
                    top: BorderSide(color: NPrimaryColor, width: 1.0),
                    right: BorderSide(color: NPrimaryColor, width: 1.0),
                    left: BorderSide(color: NPrimaryColor, width: 1.0),
                  ),
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/fb.png",
                    height: 25.0,
                  ),
                  Expanded(
                      child: Text("Facebook",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(4.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2.1,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: NPrimaryColor, width: 1.0),
                    top: BorderSide(color: NPrimaryColor, width: 1.0),
                    right: BorderSide(color: NPrimaryColor, width: 1.0),
                    left: BorderSide(color: NPrimaryColor, width: 1.0),
                  ),
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/google.png",
                    height: 25.0,
                  ),
                  Expanded(
                      child: Text("Google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0))),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed("loginPage");
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
      ]),
    );
  }
}
