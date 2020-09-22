import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final hintText;
  AppTextField({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText),
      ),
    );
  }
}
