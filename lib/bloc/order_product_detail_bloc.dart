import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:ecapp/models/response/order_product_item_response.dart';
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

  addProductReview(params) async {
    response = await _repository.addProductReview(params);
    _orderProductDetail.sink.add(response);
    return response;
  }

  updateProductReview(params) async {
    print(response);
    OrderProductItemResponse res = await _repository.updateProductReview(params, params["id"]);

    if (res.error == null) {
      var orderDetails = _orderProductDetail;
      print(response);
      // var index = orderDetails.indexWhere((element) => element.id == params["order_attribute_id"]);
      // if (index > -1) response.orderProductDetails[index] == res;
    }
  }

  void drainStream() {
    _orderProductDetail.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _orderProductDetail.drain();
    _orderProductDetail.close();
  }

  BehaviorSubject<OrderProductDetailResponse> get orderProductDetail =>
      _orderProductDetail;
}
