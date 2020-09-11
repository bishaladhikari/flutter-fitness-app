import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('I am Cart Page!'), ),
    );
  }
}

