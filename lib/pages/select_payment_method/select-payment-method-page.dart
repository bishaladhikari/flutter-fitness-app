import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/loyalty_point_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/redeem_point_response.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  @override
  _SelectPaymentMethodPageState createState() =>
      _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: selectPaymentMethodAppBar(),
      body: SelectPaymentBody(),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double totalAmount = snapshot.data.totalAmount;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<RedeemPointResponse>(
                        stream: loyaltyPointBloc.redeemAmount.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data.amountValue!=null) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr("Redeemed Amount"),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  '¥ ' +
                                      loyaltyPointBloc
                                          .redeemAmount.value.amountValue
                                          .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          '¥ ' + totalAmount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          '¥ ' + totalAmount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: NPrimaryColor,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: NPrimaryColor,
                        onPressed: () async {
//                          if (_formKey.currentState.validate()) {
//                            _formKey.currentState.save();
//                            final CreditCard testCard = CreditCard(
//                                number: _card.number,
//                                expMonth: _card.expMonth,
//                                expYear: _card.expYear);
//                            StripePayment.createTokenWithCard(testCard)
//                                .then((token) async {
//                              AddOrderResponse response =
//                              await checkoutBloc.createOrder(token: token);
//                              if (response.error == null) {
//                                Navigator.of(context).pushNamed("orderConfirmationPage",
//                                    arguments: response.order);
//                              } else
//                                _scaffoldKey.currentState.showSnackBar(SnackBar(
//                                  content: Text(
//                                    tr(response.error),
//                                  ),
//                                  backgroundColor: Colors.redAccent,
//                                ));
////                      createCharge(token.tokenId);
//                            });
////                    showDialog(
////                        context: context,
////                        barrierDismissible: false,
////                        builder: (context) =>
////                            Center(child: CircularProgressIndicator()));
//
////                    Map<String, dynamic> map = {};
////                    map['number'] = _card.number;
////                    map['cvc'] = _card.cvc;
////                    map['expMonth'] = _card.expMonth;
////                    map['expYear'] = _card.expYear;
////                    map['last4'] = _card.last4;
//                            print(_card.number.toString());
////                    var token = await stripeApi.createToken({
////                      "number": _card.number,
////                      "cvc": _card.cvc,
////                      "expMonth": _card.expMonth,
////                      "expYear": _card.expYear,
////                      "last4": _card.last4,
////                      "brand": _card.brand
////                    });
//
////                    print(token.toString());
//
////                    var paymentMethod = await stripeApi.createPaymentMethodFromCard(_cardData);
////                    paymentMethod = await stripeSession.attachPaymentMethod(paymentMethod['id']);
////                    final createSetupIntentResponse = await glappenService.createSetupIntent(paymentMethod['id']);
////                    Navigator.pop(context);
////
////                    if (createSetupIntentResponse['status'] == 'succeeded') {
////                      Navigator.pop(context, true);
////                      return;
////                    }
////                    var setupIntent = await stripe.confirmSetupIntent(createSetupIntentResponse['client_secret']);
////
////                    if (setupIntent['status'] == 'succeeded') {
////                      Navigator.pop(context, true);
////                      return;
////                    }'
//
//                          }
                        },
                        child: Text(
                          "Place order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }
}
