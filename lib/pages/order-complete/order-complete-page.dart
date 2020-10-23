import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class OrderCompletePage extends StatefulWidget {
  @override
  _OrderCompletePageState createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close), onPressed: () {
          Navigator.pushReplacementNamed(context, "ordersPage");
        },),
        backgroundColor: Colors.white,
        title: Text("Order Received".tr()),
      ),
      body: Body(),
    );
  }
}
