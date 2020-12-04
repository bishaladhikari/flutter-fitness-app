import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.75), body: Center( child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [ Transform.scale( scale: 0.8, child: CircularProgressIndicator(), ), SizedBox(width: 10.0), Text( "Loading...", style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), ), ], ), ),
    );
  }
}
