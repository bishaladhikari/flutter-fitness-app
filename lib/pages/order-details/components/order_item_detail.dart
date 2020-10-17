import 'package:ecapp/bloc/order_product_detail_bloc.dart';
import 'package:ecapp/models/order_product_detail.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:flutter/material.dart';

class OrderItemDetailPage extends StatefulWidget {
  final int id;
  OrderProductDetailBloc _orderProductDetailBloc;

  get orderDetailBloc => _orderProductDetailBloc;

  OrderItemDetailPage({Key key, this.id}) {
    _orderProductDetailBloc = OrderProductDetailBloc();
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
  OrderProductDetailBloc orderDetailBloc;

  _OrderItemDetailPageState(this.id);

  @override
  void initState() {
    super.initState();
    widget._orderProductDetailBloc..getOrderProductDetail(id);
  }

  @override
  void dispose() {
    super.dispose();
    orderDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderProductDetailResponse>(
      stream: widget._orderProductDetailBloc.orderProductDetail.stream,
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
    return Container(
        padding: EdgeInsets.only(top: 18),
        child: SizedBox(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: orderProductDetails.length,
              itemBuilder: (context, index) {
                return _buildOrderProductList(orderProductDetails[index]);
              }),
        ));
  }

  Widget _buildOrderProductList(order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 0,
          child: Row(
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(order.image_thumbnail),
                        fit: BoxFit.cover)),
              ),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    child: Text(
                      order.product_name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Sold By " + order.sold_by,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "\$ " + order.sub_total.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        "x " + order.quantity.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      SizedBox(width: 100.0),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
        // OrderItemDetailPage(id: this.id)
      ],
    );
  }
}
