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
        backgroundColor: Colors.black.withOpacity(0.01),
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Order Details"),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Ship & bill to",
                  style: TextStyle(fontSize: 16, color: Colors.black38),
                ),
                Text(
                  detail.name,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  detail.phone,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  detail.email,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  detail.address,
                  style: TextStyle(fontSize: 16, color: Colors.black38),
                ),
                OrderItemDetailPage(id: this.id),
                ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Row(
                    children: [
                      Text(
                        "Order " + detail.order_id,
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Placed on " + detail.created_date),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Row(
                    children: [
                      Text("Subtotal", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shipping Fee "),
                      ],
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          detail.sub_total.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ),
                      Text(
                        detail.shipping_cost.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black12),
                ListTile(
                  trailing: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          detail.total_quantity.toString() + " Item",
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ),
                      Text(
                        "Total: " + detail.sub_total.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
