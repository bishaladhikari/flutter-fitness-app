import 'package:flutter/material.dart';

import 'components/CartBody.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style:
              TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {

          },
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {

              },
              color: Colors.black,
          ),
        ],
      ),
      body: CartBody(),
    );
  }
}
