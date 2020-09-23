import 'package:ecapp/models/category_response.dart';
import 'package:ecapp/models/featured_product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class FeaturedProductsListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<FeaturedProductResponse> _subject =
      BehaviorSubject<FeaturedProductResponse>();

  getFeaturedProducts() async {
    FeaturedProductResponse response = await _repository.getFeaturedProducts();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FeaturedProductResponse> get subject => _subject;
}

final featuredProductsBloc = FeaturedProductsListBloc();
