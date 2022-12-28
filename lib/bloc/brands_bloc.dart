import 'package:fitnessive/models/response/address_response.dart';
import 'package:fitnessive/models/response/brand_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class BrandsBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<BrandResponse> _subject =
      BehaviorSubject<BrandResponse>();
  BrandResponse response;

  getBrands({category}) async {
    response = await _repository.getBrands(category);
    _subject.sink.add(response);
//    return response;
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<BrandResponse> get subject => _subject;
}

final BrandsBloc brandsBloc = BrandsBloc();
