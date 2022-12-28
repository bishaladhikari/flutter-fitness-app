import 'package:fitnessive/models/response/banner_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class BannerBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<BannerResponse> _subject =
      BehaviorSubject<BannerResponse>();
  BannerResponse response;

  getBanners() async {
    response = await _repository.getBanners();
    _subject.sink.add(response);

  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<BannerResponse> get banners => _subject.stream;
}

final BannerBloc bannerBloc = BannerBloc();
