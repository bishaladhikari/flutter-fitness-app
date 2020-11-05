import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/models/response/brand_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<BrandResponse> _subject =
      BehaviorSubject<BrandResponse>();
  BrandResponse response;

  getBrands() async {
    response = await _repository.getBrands();
    _subject.sink.add(response);
//    return response;
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  Stream<BrandResponse> get brands => _subject.stream;
}

final AddressBloc addressBloc = AddressBloc();
