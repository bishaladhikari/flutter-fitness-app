import 'package:ecapp/bloc/orders_byStatus.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/order.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';

class OrdersByStatus extends StatefulWidget {
  final String status;
  OrdersListByStatusBloc _ordersListByStatusBloc;

  get ordersListByStatusBloc => _ordersListByStatusBloc;

  OrdersByStatus({Key key, this.status}) {
    _ordersListByStatusBloc = OrdersListByStatusBloc();
  }

  @override
  _OrdersListByStatusState createState() => _OrdersListByStatusState(status);

  static _OrdersListByStatusState of(BuildContext context) {
    final _OrdersListByStatusState navigator = context
        .ancestorStateOfType(const TypeMatcher<_OrdersListByStatusState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a ProductDetailPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _OrdersListByStatusState extends State<OrdersByStatus> {
  final String status;

  OrdersListByStatusBloc ordersListByStatusBloc;

  _OrdersListByStatusState(this.status);

  @override
  void initState() {
    super.initState();
    widget._ordersListByStatusBloc..getOrdersByStatus(status);
  }

  @override
  void dispose() {
    super.dispose();
//    ordersListByStatusBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderResponse>(
      stream: widget._ordersListByStatusBloc.orders.stream,
      builder: (context, AsyncSnapshot<OrderResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(OrderResponse data) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Order> orders = data.orders;
    return Container(
        padding: EdgeInsets.only(top: 18),
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _buildOrderList(orders[index]),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('orderDetailPage', arguments: orders[index]);
                },
              );
            }));
  }

  Widget _buildOrderList(Order order) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: Row(
        children: [
          Text("Order "+order.order_id,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
          SizedBox(width: 5.0,),
          Icon(Icons.keyboard_arrow_right,color: Colors.black26,),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Placed on "+ order.created_date),
            SizedBox(height:5.0),
            Text("Total Items: "+order.total_quantity.toString())
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          order.payment_status.toString(),
          style: TextStyle(fontSize: 14, color: Colors.black38),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      height: 150.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
              child: Container(
                width: 70.0,
                child: Text(
                  order.order_id,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: Text(
                        order.created_at,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: 200.0,
                      child: Text(
                        order.sub_total.toString(),
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          order.status,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          order.total_quantity.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: 70.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          order.status,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
