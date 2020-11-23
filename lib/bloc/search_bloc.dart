import 'package:ecapp/models/response/search_suggestion_response.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<SearchSuggestionResponse> _subject =
      BehaviorSubject<SearchSuggestionResponse>();
  SearchSuggestionResponse response;

  getSearchSuggestions(String query) async {
    response = await _repository.getSearchSuggestions(query);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<SearchSuggestionResponse> get subject => _subject;
}

final SearchBloc searchBloc = SearchBloc();
