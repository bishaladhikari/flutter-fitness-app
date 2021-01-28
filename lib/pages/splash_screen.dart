import 'dart:async';
import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:page_transition/page_transition.dart';

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
          context, PageTransition(type:PageTransitionType.leftToRightWithFade,child: MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: SlideTransition(
                  position:
                  Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                      .animate(_animationController),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/icons/site-logo.png",scale: 10,)
                    ],
                  ),
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
