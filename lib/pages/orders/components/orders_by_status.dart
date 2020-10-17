import 'package:ecapp/bloc/orders_byStatus.dart';
import 'package:ecapp/models/order.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    ordersListByStatusBloc..drainStream();
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
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blueAccent),
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
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery
        .of(context)
        .orientation;
    List<Order> orders = data.orders;
    return Container(
        padding: EdgeInsets.only(top: 18),
        child: (
            Text("")
        ),
    );
  }
}
