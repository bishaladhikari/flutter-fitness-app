import 'package:fitnessive/models/response/store_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class StoreBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<StoreResponse> _subject =
      BehaviorSubject<StoreResponse>();

  StoreResponse response;

  getStoreDetail(String storeSlug) async {
    response = await _repository.getStoreDetail(storeSlug);
    _subject.sink.add(response);
    return response;
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<StoreResponse> get subject => _subject;
}

final StoreBloc storeBloc = StoreBloc();
