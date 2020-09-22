import 'package:ecapp/widgets/widgets-index.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage>
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
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(
          height: 200,
          color: Colors.deepOrangeAccent,
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
                Text("Shopping Made Easy!", style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Sign In!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20.0)),
  ),
        ),
        AppTextField(hintText: "Email"),
        AppTextField(hintText: "Password"),
        Container(
          alignment: Alignment.centerRight,
child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Forget Password?', style: TextStyle(color: Colors.black, fontSize: 15.0)),
  ),
          ),
        Container(
          height: 50.0,
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent, borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: Text("SIGN IN")),
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
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Text("Facebook"),
              color: Colors.deepOrangeAccent,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Text("Google"),
              color: Colors.deepOrangeAccent,
            ),
          ],
        )
      ]),
    );
  }
}
