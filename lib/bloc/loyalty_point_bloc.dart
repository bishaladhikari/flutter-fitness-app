import 'package:fitnessive/models/response/loyalty_point_response.dart';
import 'package:fitnessive/models/response/redeem_point_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'checkout_bloc.dart';

class LoyaltyPointBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<LoyaltyPointResponse> _subject =
      BehaviorSubject<LoyaltyPointResponse>();

  final BehaviorSubject<RedeemPointResponse> _redeemResponse =
      BehaviorSubject<RedeemPointResponse>();
  double _cashOnDeliveryCharge = 0.0;

  LoyaltyPointResponse response;

  getLoyaltyPoint(amount) async {
    var params = {
      "amount": amount,
      "final_total": checkoutBloc.finalTotalAmount
    };
    LoyaltyPointResponse response = await _repository.loyaltyPoints(params);
    _subject.sink.add(response);
    if (response.error == null)
      _cashOnDeliveryCharge = response.cashOnDeliveryCharge;
    return response;
  }

  redeemPoints(params) async {
    RedeemPointResponse response =
        await _repository.redeemLoyaltyPoints(params);
    _redeemResponse.sink.add(response);
    if (response.error == null)
      _cashOnDeliveryCharge = response.cashOnDeliveryCharge;
    return response;
  }

  void drainStream() {
    _subject.value = null;
    _redeemResponse.value = null;
    _cashOnDeliveryCharge = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _redeemResponse.drain();
    _redeemResponse.close();
  }

  BehaviorSubject<LoyaltyPointResponse> get subject => _subject;

  BehaviorSubject<RedeemPointResponse> get redeemResponse => _redeemResponse;

  get cashOnDeliveryCharge => _cashOnDeliveryCharge??0.0;
}

final LoyaltyPointBloc loyaltyPointBloc = LoyaltyPointBloc();
