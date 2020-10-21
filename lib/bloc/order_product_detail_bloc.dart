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
    OrderProductItemResponse itemResponse =
        await _repository.addProductReview(params);

    if (itemResponse.error == null) {
      var index = response.orderProductDetails.indexWhere((element) =>
          element.orderAttributeId == params["order_attribute_id"]);
      print(index);
      if (index > -1)
        response.orderProductDetails[index] = itemResponse.orderProductItem;
    }
    return response;
  }

  updateProductReview(params) async {
    OrderProductItemResponse res =
        await _repository.updateProductReview(params, params["id"]);

    if (res.error == null) {
      var index = response.orderProductDetails.indexWhere((element) =>
          element.orderAttributeId == params["order_attribute_id"]);
      print(index);
      if (index > -1)
        response.orderProductDetails[index] = res.orderProductItem;
    }
    return response;
  }

  deleteProductReview(params) async {
    OrderProductItemResponse resp =
        await _repository.deleteProductReview(params["id"]);

    if (resp.error == null) {
      var index = response.orderProductDetails.indexWhere((element) =>
          element.orderAttributeId == params["order_attribute_id"]);
      if (index > -1)
        response.orderProductDetails[index] = resp.orderProductItem;
    }
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

  BehaviorSubject<OrderProductDetailResponse> get orderProductDetail =>
      _orderProductDetail;
}

final orderProductDetailBloc = OrderProductDetailBloc();
