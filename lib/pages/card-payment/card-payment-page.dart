import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CardPaymentPage extends StatefulWidget {
  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StripeCard _card = StripeCard();
  GlobalKey<FormState> _formKey = GlobalKey();
  StripeApi stripeApi;

  @override
  void initState() {
//    stripeApi = StripeApi(
//        "pk_test_51HLfupKoHgRHkB8gxXW89hAxj3pQFdve3FsoYJPh5izaYtVdFHppAjG00TWQo6ldxDW6gF4jsK7i4c4fX7PjW18900xZTBCswt");
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HLfupKoHgRHkB8gxXW89hAxj3pQFdve3FsoYJPh5izaYtVdFHppAjG00TWQo6ldxDW6gF4jsK7i4c4fX7PjW18900xZTBCswt",
        merchantId: "Test",
        androidPayMode: 'test'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardPaymentAppBar(),
      body: Body(formKey: _formKey, card: _card),
      bottomNavigationBar:
      StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double totalAmount = snapshot.data.totalAmount;
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 130,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
//                      fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          '¥ ' + checkoutBloc.billableAmount.toString(),
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
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: NPrimaryColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            final CreditCard testCard = CreditCard(
                                number: _card.number,
                                expMonth: _card.expMonth,
                                expYear: _card.expYear);
                            StripePayment.createTokenWithCard(testCard)
                                .then((token) async {
                              AddOrderResponse response =
                              await checkoutBloc.createOrder(context:context,token: token);
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
//                      createCharge(token.tokenId);
                            });
//                    showDialog(
//                        context: context,
//                        barrierDismissible: false,
//                        builder: (context) =>
//                            Center(child: CircularProgressIndicator()));

//                    Map<String, dynamic> map = {};
//                    map['number'] = _card.number;
//                    map['cvc'] = _card.cvc;
//                    map['expMonth'] = _card.expMonth;
//                    map['expYear'] = _card.expYear;
//                    map['last4'] = _card.last4;
                            print(_card.number.toString());
//                    var token = await stripeApi.createToken({
//                      "number": _card.number,
//                      "cvc": _card.cvc,
//                      "expMonth": _card.expMonth,
//                      "expYear": _card.expYear,
//                      "last4": _card.last4,
//                      "brand": _card.brand
//                    });

//                    print(token.toString());

//                    var paymentMethod = await stripeApi.createPaymentMethodFromCard(_cardData);
//                    paymentMethod = await stripeSession.attachPaymentMethod(paymentMethod['id']);
//                    final createSetupIntentResponse = await glappenService.createSetupIntent(paymentMethod['id']);
//                    Navigator.pop(context);
//
//                    if (createSetupIntentResponse['status'] == 'succeeded') {
//                      Navigator.pop(context, true);
//                      return;
//                    }
//                    var setupIntent = await stripe.confirmSetupIntent(createSetupIntentResponse['client_secret']);
//
//                    if (setupIntent['status'] == 'succeeded') {
//                      Navigator.pop(context, true);
//                      return;
//                    }'

                          }
                        },
                        child: Text(
                          "Place order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }
}
