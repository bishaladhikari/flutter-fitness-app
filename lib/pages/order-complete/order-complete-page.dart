import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/models/order.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class OrderCompletePage extends StatefulWidget {
  Order order;

  OrderCompletePage({Key key, this.order}) : super(key: key);

  @override
  _OrderCompletePageState createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {
  Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "ordersPage");
          },
        ),
        backgroundColor: Colors.white,
        title: Text(tr("Order Received")),
      ),
      body: Body(order: widget.order),
    );
  }
}
