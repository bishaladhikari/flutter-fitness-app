import 'package:ecapp/models/order.dart';
import 'package:flutter/material.dart';

import 'components/order_item_detail.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Object detail;
  int id;

  @override
  void initState() {
    super.initState();
    detail = widget.order;
    id = widget.order.id;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            OrderItemDetailPage(id: this.id)
          ],
        ),
      ),
    );
  }
}
