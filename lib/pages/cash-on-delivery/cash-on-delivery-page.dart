import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:ecapp/models/response/cart_response.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: cashOnDeliveryAppBar(),
      body: Body(),
      bottomNavigationBar: StreamBuilder<CartResponse>(
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
                          AddOrderResponse response =
                              await checkoutBloc.createOrder(paymentMethod: "Cash Payment");
                          if (response.error == null) {
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(
                                "orderConfirmationPage",
                                arguments: response.order);
                          } else{
                            Navigator.pop(context);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                tr(response.error),
                              ),
                              backgroundColor: Colors.redAccent,
                            ));
                          }

                        },
                        child: Text(
                          "Confirm Order".tr(),
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
