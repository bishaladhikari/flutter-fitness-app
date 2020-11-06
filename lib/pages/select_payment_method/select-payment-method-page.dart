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
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 90,
                child: Column(
                  children: [
                    StreamBuilder<RedeemPointResponse>(
                        stream: loyaltyPointBloc.redeemAmount.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
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
