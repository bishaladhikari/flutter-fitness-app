import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/orders_by_status_bloc.dart';
import 'package:ecapp/models/meta.dart';
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
  int page = 1;

  _OrdersListByStatusState(this.status);

  ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    getOrderByStatus();

    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      if (currentPosition >= maxScrollExtent) {
        Meta meta = widget.ordersListByStatusBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          getOrderByStatus();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
//    ordersListByStatusBloc..drainStream();
  }

  getOrderByStatus() {
    widget._ordersListByStatusBloc..getOrdersByStatus(status, page);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderResponse>(
      stream: widget._ordersListByStatusBloc.subject.stream,
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
        Text(tr("Error occurred: $error")),
      ],
    ));
  }

  Future<Null> refreshOrder() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      new OrdersByStatus();
    });

    return null;
  }

  Widget _buildHomeWidget(OrderResponse data) {
    List<Order> orders = data.orders;
    if (orders.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  tr("No Orders Found"),
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return RefreshIndicator(
        onRefresh: refreshOrder,
        child: NotificationListener<OverscrollIndicatorNotification>(
          // ignore: missing_return
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: Container(
              padding: EdgeInsets.only(top: 18),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: orders.length + 1,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    if (index == orders.length) {
                      return Center(child: CupertinoActivityIndicator());
                    }
                    return GestureDetector(
                      child: _buildOrderList(orders[index]),
                      onTap: () {
                        Navigator.of(context).pushNamed('orderDetailPage',
                            arguments: orders[index]);
                      },
                    );
                  })),
        ),
      );
  }

  Widget _buildOrderList(Order order) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: Row(
        children: [
          Text(
            tr("Order ") + order.orderId,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black26,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr("Placed on ") + order.createdDate),
            SizedBox(height: 5.0),
            Text(tr("Total Items: ") + order.totalQuantity.toString())
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          order.paymentStatus.toString(),
          style: TextStyle(
              fontSize: 14, color: Colors.black38, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
