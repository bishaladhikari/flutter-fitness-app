import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/bloc/checkout_bloc.dart';
import 'package:fitnessive/bloc/loyalty_point_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/response/add_order_response.dart';
import 'package:fitnessive/models/response/cart_response.dart';
import 'package:fitnessive/models/response/loyalty_point_response.dart';
import 'package:fitnessive/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CashOnDeliveryPage extends StatefulWidget {
  @override
  _CashOnDeliveryPageState createState() => _CashOnDeliveryPageState();
}

class _CashOnDeliveryPageState extends State<CashOnDeliveryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkoutBloc.paymentMethod.value = "Cash Payment";
    super.initState();
  }

  @override
  void dispose() {
    checkoutBloc.paymentMethod.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: cashOnDeliveryAppBar(),
      body: Center(child: Body()),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var cartTotalAmount = snapshot.data.cartSummary.totalAmount;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("Subtotal"),
                          style: TextStyle(
//                      fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
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
                              color: NPrimaryColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    StreamBuilder<LoyaltyPointResponse>(
                        stream: loyaltyPointBloc.subject.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr("Cash on delivery charge"),
                                  style: TextStyle(
//                              fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                                Text(
                                  '¥ ' +
                                      loyaltyPointBloc.cashOnDeliveryCharge
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )
                              ],
                            );
                          return Container();
                        }),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("Payable Total Amount"),
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
                        ),
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
                          showDialog(
                              context: context,
                              barrierColor: Colors.white70,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()));
                          checkoutBloc.paymentMethod.value = "Cash Payment";
                          AddOrderResponse response =
                              await checkoutBloc.createOrder(context: context);
//                          if (response.error == null) {
//                            Navigator.pop(context);
//                            Navigator.of(context).pushNamed(
//                                "orderConfirmationPage",
//                                arguments: response.order);
//                          } else {
//                            Navigator.pop(context);
//                            _scaffoldKey.currentState.showSnackBar(SnackBar(
//                              content: Text(
//                                tr(response.error),
//                              ),
//                              backgroundColor: Colors.redAccent,
//                            ));
//                          }
                        },
                        child: Text(
                          tr("Confirm Order"),
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
