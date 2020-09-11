import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  int cc = 0;
  Future<void> _getCt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cc = prefs.getInt('count');
    });
    print (cc);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child : Text('I am Category Page!'),
      ),
    );
  }
}

