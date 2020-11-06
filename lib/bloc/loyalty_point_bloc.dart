import 'package:ecapp/models/response/loyalty_point_response.dart';
import 'package:ecapp/models/response/redeem_point_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class LoyaltyPointBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<LoyaltyPointResponse> _subject =
      BehaviorSubject<LoyaltyPointResponse>();

  final BehaviorSubject<RedeemPointResponse> _redeemAmount =
      BehaviorSubject<RedeemPointResponse>();

  LoyaltyPointResponse response;

  getLoyaltyPoint(int amount) async {
    LoyaltyPointResponse response = await _repository.loyaltyPoints(amount);
    _subject.sink.add(response);
    return response;
  }

  redeemPoints(params) async {
    RedeemPointResponse response =
        await _repository.redeemLoyaltyPoints(params);
    _redeemAmount.sink.add(response);
    return response;
  }

  void drainStream() {
    _subject.value = null;
    _redeemAmount.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
    await _redeemAmount.drain();
    _redeemAmount.close();
  }

  BehaviorSubject<LoyaltyPointResponse> get subject => _subject;

  BehaviorSubject<RedeemPointResponse> get redeemAmount => _redeemAmount;
}

final LoyaltyPointBloc loyaltyPointBloc = LoyaltyPointBloc();
