import '../customer_review.dart';

class CustomerReviewResponse {
  CustomerReview customerReview;
  final String error;

  CustomerReviewResponse(this.customerReview, this.error);

  CustomerReviewResponse.fromJson(Map<String, dynamic> json)
      : customerReview = CustomerReview.fromJson(json["data"]),
        error = null;

  CustomerReviewResponse.withError(String errorValue)
      : customerReview = CustomerReview(),
        error = errorValue;
}
