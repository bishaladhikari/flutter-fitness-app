import 'package:fitnessive/models/response/customer_review_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CustomerReviewBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<CustomerReviewResponse> _customerReview =
      BehaviorSubject<CustomerReviewResponse>();

  CustomerReviewResponse response;

  getProductReviewById(String reviewId) async {
    response = await _repository.getProductReviewById(reviewId);
    _customerReview.sink.add(response);
    return response;
  }

  void drainStream() {
    _customerReview.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _customerReview.drain();
    _customerReview.close();
  }

  BehaviorSubject<CustomerReviewResponse> get customerReview => _customerReview;
}
