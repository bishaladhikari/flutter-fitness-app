import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CardPaymentAppBar(),
      body: Body(formKey: _formKey, card: _card),
      bottomNavigationBar: Container(
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
                  "Rs 4,201",
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
                  "Rs 4,201",
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
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()));
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
//                    }
                  }
                },
                child: Text(
                  "Place order",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
