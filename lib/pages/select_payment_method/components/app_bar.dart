import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';

AppBar SelectPaymentMethodAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    brightness: Brightness.dark,
    elevation: 1,
    title: Text("Select Payment Method",style: TextStyle(fontSize: 16),),
  );
}
