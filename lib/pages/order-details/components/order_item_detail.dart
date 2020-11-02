import 'package:ecapp/bloc/order_product_detail_bloc.dart';
import 'package:ecapp/models/order.dart';
import 'package:ecapp/models/order_product_detail.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class OrderItemDetails extends StatefulWidget {
  final int id;
  Order orderDetail;
  OrderProductDetailBloc _orderProductDetailBloc;

  get orderDetailBloc => _orderProductDetailBloc;

  OrderItemDetails({Key key, this.id, this.orderDetail});

  @override
  _OrderItemDetailsState createState() => _OrderItemDetailsState(id);

  static _OrderItemDetailsState of(BuildContext context) {
    final _OrderItemDetailsState navigator = context
        .ancestorStateOfType(const TypeMatcher<_OrderItemDetailsState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a OrderItemDetailPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _OrderItemDetailsState extends State<OrderItemDetails>
    with TickerProviderStateMixin {
  final int id;
  Order orderDetail;

  _OrderItemDetailsState(this.id);

  @override
  void initState() {
    super.initState();
    orderProductDetailBloc..getOrderProductDetail(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderProductDetailResponse>(
      stream: orderProductDetailBloc.orderProductDetail.stream,
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
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircularProgressIndicator(),
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
    List<OrderProductDetail> orderProductDetails = data.orderProductDetails;
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            orderProductDetails.map((OrderProductDetail orderProductDetail) {
          return _buildOrderProductListItem(orderProductDetail);
        }).toList());
  }

  Widget _buildOrderProductListItem(orderProductDetail) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(orderProductDetail.imageThumbnail),
                        fit: BoxFit.cover)),
              ),
              title: Text(
                orderProductDetail.productName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sold By " + orderProductDetail.soldBy,
                    style: TextStyle(
                        fontSize: 14,
//                          fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "\¥ " + orderProductDetail.subTotal.toString(),
                    style: TextStyle(
                        fontSize: 14,
//                          fontWeight: FontWeight.w500,
                        color: NPrimaryColor),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "x" + orderProductDetail.quantity.toString(),
                    style: TextStyle(
                        fontSize: 14,
//                          fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              trailing: widget.orderDetail.status == 'Delivered'
                  ? RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.of(context).pushNamed('orderReviewPage',
                            arguments: orderProductDetail);
                      },
                      child: orderProductDetail.reviewed
                          ? Text('View Review', style: TextStyle(fontSize: 11))
                          : Text('Place Review',
                              style: TextStyle(fontSize: 11)),
                      color: Colors.orange,
                      textColor: Colors.white,
                      splashColor: NPrimaryColor,
                    )
                  : Text("")),
        ],
      ),
    );
  }
}
