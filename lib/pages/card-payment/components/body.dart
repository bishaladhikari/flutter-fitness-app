import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.01),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
//              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.black.withOpacity(.01),
              child: Row(
                children: [
                  Text(
                    'Add a New Credit/Debit Card',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.security,
//                    size: 18,
                    color: NPrimaryColor,
                  ),
                  SizedBox(width: 4.0,),
                  Container(
                      width: 80,
                      child: Text(
                        "Security Guaranteed",
                        style: TextStyle(color: NPrimaryColor,fontSize: 12),
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("We accept following credit cards:"),
                      Image.asset(
                        "assets/icons/card_type_logo.png",
                        scale: 4,
                      )
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Text("Form Goes here")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
