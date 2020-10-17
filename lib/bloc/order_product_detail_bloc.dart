import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class OrderProductDetailBloc {
  final Repository _repository = Repository();

  // final BehaviorSubject<OrderResponse> _orderDetail =
  //     BehaviorSubject<OrderResponse>();

  final BehaviorSubject<OrderProductDetailResponse> _orderProductDetail =
      BehaviorSubject<OrderProductDetailResponse>();

  // OrderResponse response;
  OrderProductDetailResponse response;

  // getSingleOrderDetail(int id) async {
  //   response = await _repository.getSingleOrderDetail(id);
  //   _orderDetail.sink.add(response);
  //   return response;
  // }

  getOrderProductDetail(int id) async {
    response = await _repository.getOrderItemDetail(id);
    _orderProductDetail.sink.add(response);
    return response;
  }

  void drainStream() {
    // _orderDetail.value = null;
    _orderProductDetail.value = null;
  }

  @mustCallSuper
  void dispose() async {
    // await _orderDetail.drain();
    // _orderDetail.close();
    await _orderProductDetail.drain();
    _orderProductDetail.close();
  }

  // BehaviorSubject<OrderResponse> get orderDetail => _orderDetail;

  BehaviorSubject<OrderProductDetailResponse> get orderProductDetail => _orderProductDetail;
}
