import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: checkoutAppBar(),
      body: Body(),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var cartTotalAmount = snapshot.data.cartSummary.totalAmount;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                width: double.infinity,
                // double.infinity means it cove the available width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -7),
                      blurRadius: 33,
                      color: Color(0xFF6DAED9).withOpacity(0.11),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(tr('Total Amount'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('¥ ' + checkoutBloc.finalTotalAmount.toString(),
                        style: TextStyle(
                            color: NPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    StreamBuilder<Address>(
                        stream: addressBloc.defaultAddress,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return RaisedButton(
                              color: NPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "selectPaymentMethodPage");
                              },
                              child: Text('Proceed to Pay',
                                  style: TextStyle(color: Colors.white)),
                            );
                          } else {
                            return RaisedButton(
                              color: NPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(context, 'addressFormPage');
                              },
                              child: Text('Add Address',
                                  style: TextStyle(color: Colors.white)),
                            );
                          }
                        }),
                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }
}
