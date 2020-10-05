import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddressResponse> _addressFetcher =
      BehaviorSubject<AddressResponse>();
  AddressResponse response;

  getAddress() async {
    response = await _repository.getAddress();
    _addressFetcher.sink.add(response);
  }

  // deleteFromCart(id) async {
  //   await _repository.deleteWishlist(id);
  //   response.deleteFromWishList(id);
  //   _subject.sink.add(response);

  //   print("response:" + response.toString());
  // }

  void drainStream(){ _addressFetcher.value = null; }
  @mustCallSuper
  void dispose() async{
    await _addressFetcher.drain();
    _addressFetcher.close();
  }

  BehaviorSubject<AddressResponse> get address => _addressFetcher.stream;
}

final AddressBloc addressBloc = AddressBloc();
