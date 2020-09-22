import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final hintText;
  AppTextField({this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        
        hintStyle: TextStyle(color: Colors.grey),
        hintText: hintText),
    );
  }
}
