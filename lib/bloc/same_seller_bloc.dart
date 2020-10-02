import 'package:ecapp/models/same_seller_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SameSellerBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<SameSellerResponse> _subject =
      BehaviorSubject<SameSellerResponse>();

  getSameSellerProduct() async {
    SameSellerResponse response = await _repository.getSameSellerProduct();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SameSellerResponse> get subject => _subject;
}

final sameSellerBloc = SameSellerBloc();
