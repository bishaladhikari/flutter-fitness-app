import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/related_product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class RelatedProductsBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<RelatedProductResponse> _subject =
      BehaviorSubject<RelatedProductResponse>();

  getRelatedProduct() async {
    RelatedProductResponse response = await _repository.getRelatedProduct();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<RelatedProductResponse> get subject => _subject;
}

final relatedProductsBloc = RelatedProductsBloc();
