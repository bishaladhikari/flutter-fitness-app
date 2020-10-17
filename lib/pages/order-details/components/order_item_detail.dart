import 'package:ecapp/bloc/order_detail_bloc.dart';
import 'package:ecapp/models/order.dart';
import 'package:ecapp/models/order_product_detail.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:flutter/material.dart';

class OrderItemDetailPage extends StatefulWidget {
  final int id;
  OrderDetailBloc _orderDetailBloc;

  get orderDetailBloc => _orderDetailBloc;

  OrderItemDetailPage({Key key, this.id}) {
    _orderDetailBloc = OrderDetailBloc();
  }

  @override
  _OrderItemDetailPageState createState() => _OrderItemDetailPageState(id);

  static _OrderItemDetailPageState of(BuildContext context) {
    final _OrderItemDetailPageState navigator = context
        .ancestorStateOfType(const TypeMatcher<_OrderItemDetailPageState>());

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

class _OrderItemDetailPageState extends State<OrderItemDetailPage>
    with TickerProviderStateMixin {
  final int id;
  OrderDetailBloc orderDetailBloc;

  _OrderItemDetailPageState(this.id);

  @override
  void initState() {
    super.initState();
    widget._orderDetailBloc..getOrderItemDetail(id);
  }

  @override
  void dispose() {
    super.dispose();
    orderDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderProductDetailResponse>(
      stream: widget._orderDetailBloc.orderItemDetail.stream,
      builder: (context, AsyncSnapshot<OrderProductDetailResponse> snapshot) {
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

  Widget _buildHomeWidget(OrderProductDetailResponse data) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<OrderProductDetail> orderProductDetails = data.orderProductDetails;
    return _buildOrderList(orderProductDetails);
  }

  Widget _buildOrderList(order) {
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
                  order.id.toString(),
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
                        order.id.toString(),
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
                        order.id.toString(),
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
                          order.id.toString(),
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
                          order.id.toString(),
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
                          order.id.toString(),
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
