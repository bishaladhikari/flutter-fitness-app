import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AddressResponse> _subject =
      BehaviorSubject<AddressResponse>();
  final BehaviorSubject<Address> _defaultAddress = BehaviorSubject<Address>();
  AddressResponse response;

  getAddresses() async {
    response = await _repository.getAddresses();
    _subject.sink.add(response);
    if (response.error == null && response.addresses.length > 0)
      _defaultAddress.sink.add(response.addresses[0]);
    return response;
  }

//   addAddress(item) async{
//     await repository.addAddress(item);
// response.add(id)
// _subject.sink.add(response);

//   }

  // deleteFromCart(id) async {
  //   await _repository.deleteWishlist(id);
  //   response.deleteFromWishList(id);
  //   _subject.sink.add(response);

  //   print("response:" + response.toString());
  // }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<AddressResponse> get subject => _subject;

  BehaviorSubject<Address> get defaultAddress => _defaultAddress.stream;
}

final AddressBloc addressBloc = AddressBloc();
