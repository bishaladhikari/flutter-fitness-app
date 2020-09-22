import 'package:ecapp/models/category_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesListBloc {
  final EcomRepository _repository = EcomRepository();
  final BehaviorSubject<CategoryResponse> _subject =
      BehaviorSubject<CategoryResponse>();

  getCategories() async {
    CategoryResponse response = await _repository.getCategories();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CategoryResponse> get subject => _subject;
}

final categoryBloc = CategoriesListBloc();
