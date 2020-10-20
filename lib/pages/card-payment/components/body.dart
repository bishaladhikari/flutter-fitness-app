import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/card-payment/components/card_number_form_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey;
  final StripeCard card;
  final InputDecoration cardNumberDecoration;
  final TextStyle cardNumberTextStyle;
  final InputDecoration cardExpiryDecoration;
  final TextStyle cardExpiryTextStyle;
  final InputDecoration cardCvcDecoration;
  final TextStyle cardCvcTextStyle;
  final String cardNumberErrorText;
  final String cardExpiryErrorText;
  final String cardCvcErrorText;
  final Decoration cardDecoration;

  Body({Key key, this.cardNumberDecoration, this.cardNumberTextStyle, this.cardExpiryDecoration, this.cardExpiryTextStyle, this.cardCvcDecoration, this.cardCvcTextStyle, this.cardNumberErrorText, this.cardExpiryErrorText, this.cardCvcErrorText, this.cardDecoration, this.formKey, this.card})
      :
//        card = StripeCard(),
//        formKey = GlobalKey(),
        super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final StripeCard _validationModel = StripeCard();
  @override
  Widget build(BuildContext context) {
    var cardExpiry = 'MM/YY';
    if (_validationModel.expMonth != null) {
      cardExpiry = "${_validationModel.expMonth}/${_validationModel.expYear ?? 'YY'}";
    }
    return SingleChildScrollView(
      child: Container(
        color: Colors.black.withOpacity(.01),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
//              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.black.withOpacity(.01),
                child: Row(
                  children: [
                    Text(
                      'Add a New Credit/Debit Card',
                      style: TextStyle(color: Colors.black),
                    ),
                    Spacer(),
                    Icon(
                      Icons.security,
//                    size: 18,
                      color: NPrimaryColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Container(
                        width: 80,
                        child: Text(
                          "Security Guaranteed",
                          style: TextStyle(color: NPrimaryColor, fontSize: 12),
                        ))
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("We accept following credit cards:"),
                        Image.asset(
                          "assets/icons/card_type_logo.png",
                          scale: 4,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Form(
                      key: widget.formKey,
                      autovalidate: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.only(top: 16),
                              child: CustomCardNumberFormField(
                                initialValue: _validationModel.number ?? widget.card.number,
                                onChanged: (number) {
                                  setState(() {
                                    _validationModel.number = number;
                                  });
                                },
                                validator: (text) => _validationModel.validateNumber()
                                    ? null
                                    : widget.cardNumberErrorText ?? CardNumberFormField.defaultErrorText,
                                textStyle: widget.cardNumberTextStyle ?? CardNumberFormField.defaultTextStyle,
                                onSaved: (text) => widget.card.number = text,
                                decoration: widget.cardNumberDecoration ?? CardNumberFormField.defaultDecoration,
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                margin: const EdgeInsets.only(top: 8),
                                child: CardExpiryFormField(
                                  initialMonth: _validationModel.expMonth ?? widget.card.expMonth,
                                  initialYear: _validationModel.expYear ?? widget.card.expYear,
                                  onChanged: (int month, int year) {
                                    setState(() {
                                      _validationModel.expMonth = month;
                                      _validationModel.expYear = year;
                                    });
                                  },
                                  onSaved: (int month, int year) {
                                    widget.card.expMonth = month;
                                    widget.card.expYear = year;
                                  },
                                  validator: (text) => _validationModel.validateDate()
                                      ? null
                                      : widget.cardExpiryErrorText ?? CardExpiryFormField.defaultErrorText,
                                  textStyle: widget.cardExpiryTextStyle ?? CardExpiryFormField.defaultTextStyle,
                                  decoration: widget.cardExpiryDecoration ?? CardExpiryFormField.defaultDecoration,
                                )),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              margin: const EdgeInsets.only(top: 8),
                              child: CardCvcFormField(
                                initialValue: _validationModel.cvc ?? widget.card.cvc,
                                onChanged: (text) => setState(() => _validationModel.cvc = text),
                                onSaved: (text) => widget.card.cvc = text,
                                validator: (text) => _validationModel.validateCVC()
                                    ? null
                                    : widget.cardCvcErrorText ?? CardCvcFormField.defaultErrorText,
                                textStyle: widget.cardCvcTextStyle ?? CardCvcFormField.defaultTextStyle,
                                decoration: widget.cardCvcDecoration ?? CardCvcFormField.defaultDecoration,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
