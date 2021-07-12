import 'package:rakurakubazzar/models/meta.dart';
import '../review.dart';

class ReviewResponse {
  final List<Review> reviews;
  final String error;
  final Meta meta;

  ReviewResponse(this.reviews, this.error, this.meta);

  ReviewResponse.fromJson(Map<String, dynamic> json)
      : reviews =
            (json["data"] as List).map((i) => new Review.fromJson(i)).toList(),
        meta = Meta.fromJson(json["meta"]),
        error = null;

  ReviewResponse.withError(String errorValue)
      : reviews = List(),
        meta = Meta(),
        error = errorValue;
}
