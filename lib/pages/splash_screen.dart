import 'dart:async';
import 'package:flutter/material.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.green),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                              .animate(_animationController),
                      child: Text(
                        "Ecapp",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         CircularProgressIndicator(
            //           backgroundColor: Colors.white,
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(top: 20.0),
            //         ),
            //       ]),
            // )
          ],
        )
      ],
    ));
  }
}
