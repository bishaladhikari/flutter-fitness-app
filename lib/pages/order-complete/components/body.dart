import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/order.dart';
import 'package:flutter/material.dart';


class Body extends StatefulWidget {
  Order order;

  Body({Key key, this.order}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  Order order;

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
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Order " + widget.order.orderId,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )),
          SizedBox(
            height: 20,
          ),
          Card(
              elevation: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      tr("Track your delivery status"),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  OutlineButton(
                    child: Text("View Order"),
                    color: NPrimaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, "ordersPage");
                    },
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
            onPressed: () {
              Navigator.pushNamed(context, "mainPage");
            },
          )
        ],
      ),
    );
  }
}
