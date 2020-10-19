import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ReviewResponse> _review =
      BehaviorSubject<ReviewResponse>();
  ReviewResponse response;

  getProductReview(String combo, String slug) async {
    response = await _repository.getProductReview(combo, slug);
    _review.sink.add(response);
  }

  void drainStream() {
    _review.value = null;
  }

  void dispose() async {
    await _review.drain();
    _review.close();
  }

  BehaviorSubject<ReviewResponse> get review => _review;
}

final ReviewBloc reviewBloc = ReviewBloc();
