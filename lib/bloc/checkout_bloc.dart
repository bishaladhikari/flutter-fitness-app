import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddressResponse> _subject =
      BehaviorSubject<AddressResponse>();
  AddressResponse response;

  createOrder(params) async {
//    response = await _repository.createOrder(params);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<AddressResponse> get addresses => _subject.stream;
}

final CheckoutBloc checkoutBloc = CheckoutBloc();
