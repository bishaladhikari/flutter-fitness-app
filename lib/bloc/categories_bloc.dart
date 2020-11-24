import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CategoryResponse> _subject =
      BehaviorSubject<CategoryResponse>();
  final BehaviorSubject<int> _selectedCategoryIndex =
  BehaviorSubject<int>();

  getCategories() async {
    CategoryResponse response = await _repository.getCategories();
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CategoryResponse> get subject => _subject;
  BehaviorSubject<int> get selectedCategoryIndex => _selectedCategoryIndex;
}

final categoryBloc = CategoriesListBloc();
