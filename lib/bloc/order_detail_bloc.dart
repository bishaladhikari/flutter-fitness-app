import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class OrderDetailBloc {
  final Repository _repository = Repository();

  // final BehaviorSubject<OrderResponse> _orderDetail =
  //     BehaviorSubject<OrderResponse>();

  final BehaviorSubject<OrderProductDetailResponse> _orderItemDetail =
      BehaviorSubject<OrderProductDetailResponse>();

  // OrderResponse response;
  OrderProductDetailResponse response;

  // getSingleOrderDetail(int id) async {
  //   response = await _repository.getSingleOrderDetail(id);
  //   _orderDetail.sink.add(response);
  //   return response;
  // }

  getOrderItemDetail(int id) async {
    response = await _repository.getOrderItemDetail(id);
    _orderItemDetail.sink.add(response);
    return response;
  }

  void drainStream() {
    // _orderDetail.value = null;
    _orderItemDetail.value = null;
  }

  @mustCallSuper
  void dispose() async {
    // await _orderDetail.drain();
    // _orderDetail.close();
    await _orderItemDetail.drain();
    _orderItemDetail.close();
  }

  // BehaviorSubject<OrderResponse> get orderDetail => _orderDetail;

  BehaviorSubject<OrderProductDetailResponse> get orderItemDetail => _orderItemDetail;
}
