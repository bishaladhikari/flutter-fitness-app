import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Thank you for your order!",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(child: Text("Order "+ "#0016",style: TextStyle(fontSize: 16,color: Colors.black),)),
          SizedBox(height: 20,),
          Card(
              elevation: 0,
              child: Row(
                children: [
                  Text(
                    "Track your delivery status",
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  OutlineButton(
                    child: Text("View Order"),
                    color: NPrimaryColor,
                    onPressed: () {},
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.mail_outline),
            title: Text(
                "A confirmation email with the order details has been sent."),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text(
              "Continue Shopping",
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            color: NPrimaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
