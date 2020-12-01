import 'package:flutter/material.dart';
import 'components/body.dart';

class NoInternetPage extends StatefulWidget {
  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
        ),
        body: Body());
  }
}
