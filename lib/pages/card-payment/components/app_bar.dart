import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';

AppBar CardPaymentAppBar() {
  return AppBar(
    brightness: Brightness.dark,
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text("Credit/Debit Card",style: TextStyle(fontSize: 16),),
  );
}
