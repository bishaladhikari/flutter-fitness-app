import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class OrderProductDetailBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<OrderProductDetailResponse> _orderProductDetail =
      BehaviorSubject<OrderProductDetailResponse>();

  OrderProductDetailResponse response;


  getOrderProductDetail(int id) async {
    response = await _repository.getOrderItemDetail(id);
    _orderProductDetail.sink.add(response);
    return response;
  }

  addProductReview(params) async{
    response = await _repository.addProductReview(params);
    _orderProductDetail.sink.add(response);
    return response;
  }

  void drainStream() {
    _orderProductDetail.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _orderProductDetail.drain();
    _orderProductDetail.close();
  }

  BehaviorSubject<OrderProductDetailResponse> get orderProductDetail => _orderProductDetail;
}
