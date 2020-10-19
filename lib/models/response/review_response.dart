import '../review.dart';

class ReviewResponse {
  final List<Review> reviews;
  final String error;

  ReviewResponse(this.reviews, this.error);

  ReviewResponse.fromJson(Map<String, dynamic> json)
      : reviews =
            (json["data"] as List).map((i) => new Review.fromJson(i)).toList(),
        error = "";

  ReviewResponse.withError(String errorValue)
      : reviews = List(),
        error = errorValue;
}
