import 'package:rakurakubazzar/models/address.dart';
import 'package:rakurakubazzar/models/response/address_response.dart';
import 'package:rakurakubazzar/models/response/default_address_response.dart';
import 'package:rakurakubazzar/repository/repository.dart';
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
    if (response.error == null && response.addresses.length > 0) {
      var defaultAddressIndex =
          response.addresses.indexWhere((element) => element.isDefault == true);
      if (defaultAddressIndex > -1)
        _defaultAddress.sink.add(response.addresses[defaultAddressIndex]);
    }
    return response;
  }

  setDefaultAddress(address) async {
    DefaultAddressResponse defaultAddressResponse =
        await _repository.setDefaultAddress(address.id);
    if (defaultAddressResponse.error == null) {
      _defaultAddress.sink.add(defaultAddressResponse.address);
    }
    return defaultAddressResponse;
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
