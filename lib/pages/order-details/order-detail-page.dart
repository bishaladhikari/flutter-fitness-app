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
  Order detail;
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Tracking order: " + detail.order_id,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Address: " + detail.address,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Name: " + detail.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Contact: " + detail.phone,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Email: " + detail.email,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  OrderItemDetailPage(id: this.id),
                ],
              ),
            ],
          ),
        ));
  }
}
