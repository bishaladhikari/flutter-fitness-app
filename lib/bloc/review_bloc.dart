import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ReviewResponse> _subject =
      BehaviorSubject<ReviewResponse>();

  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  ReviewResponse reviewResponse;

  getProductReview(String combo, String slug, int pageNumber) async {
    _loading.sink.add(true);
    ReviewResponse response =
        await _repository.getProductReview(combo, slug, pageNumber);

    if (response.error == null) {
      if (reviewResponse != null && reviewResponse.reviews.length > 0) {
        reviewResponse.reviews.addAll(response.reviews);
      } else {
        reviewResponse = response;
      }
    } else {
      reviewResponse = response;
    }

    _loading.sink.add(false);
    _subject.sink.add(reviewResponse);
    return reviewResponse;
  }

  // getProductReview(String combo, String slug) async {
  //   response = await _repository.getProductReview(combo, slug);
  //   _subject.sink.add(response);
  // }

  void drainStream() {
    _subject.value = null;
  }

  void dispose()  {
    _subject.close();
  }

  BehaviorSubject<ReviewResponse> get subject => _subject;

  Stream<bool> get loading => _loading.stream;
}

final ReviewBloc reviewBloc = ReviewBloc();
