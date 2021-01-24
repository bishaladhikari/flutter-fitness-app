import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
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
              var cartTotalAmount = snapshot.data.cartSummary.totalAmount;
              return Container(
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                // double.infinity means it cove the available width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -7),
                      blurRadius: 33,
                      color: Color(0xFF6DAED9).withOpacity(0.11),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // StreamBuilder<RedeemPointResponse>(
                    //     stream: loyaltyPointBloc.redeemResponse.stream,
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData &&
                    //           snapshot.data.amountValue != null) {
                    //         return Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               tr("Redeemed Amount"),
                    //               style: TextStyle(
                    //                   color: Colors.black, fontSize: 16),
                    //             ),
                    //             Text(
                    //               '¥ ' +
                    //                   loyaltyPointBloc
                    //                       .redeemResponse.value.amountValue
                    //                       .toString(),
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w400,
                    //                   color: Colors.black,
                    //                   fontSize: 16),
                    //             )
                    //           ],
                    //         );
                    //       } else {
                    //         return Container();
                    //       }
                    //     }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          '¥ ' + cartTotalAmount.toStringAsFixed(2),
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
                          tr("Total Amount"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          '¥ ' + checkoutBloc.finalTotalAmount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    StreamBuilder<RedeemPointResponse>(
                        stream: loyaltyPointBloc.redeemResponse.stream,
                        builder: (context, snapshot) {
                          if (!(snapshot.hasData &&
                              snapshot.data.amountValue != null))
                            return Container();
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("Redeemed Amount"),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    '¥ ' +
                                        loyaltyPointBloc
                                            .redeemResponse.value.amountValue
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("Payable total Amount"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '¥ ' + checkoutBloc.payableTotal.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: NPrimaryColor,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              checkoutBloc.finalTotalAmount <=
                                      snapshot.data.amountValue
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: FlatButton(
                                        color: NPrimaryColor,
                                        onPressed: () async {
                                          checkoutBloc.createOrder(
                                              context: context);
                                        },
                                        child: Text(
                                          tr("Place order"),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        }),
                    // StreamBuilder<RedeemPointResponse>(
                    //     stream: loyaltyPointBloc.redeemResponse.stream,
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData &&
                    //           snapshot.data.amountValue != null &&
                    //           snapshot.data.amountValue >=
                    //               cartTotalAmount.toInt())
                    //         return SizedBox(
                    //           width: double.infinity,
                    //           height: 50,
                    //           child: FlatButton(
                    //             color: NPrimaryColor,
                    //             onPressed: () async {
                    //               checkoutBloc.createOrder(context: context);
                    //             },
                    //             child: Text(
                    //               "Place order",
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //           ),
                    //         );
                    //       return Container();
                    //     })
                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }
}
