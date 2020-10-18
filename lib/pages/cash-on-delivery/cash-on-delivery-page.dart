import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/add_order_response.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CashOnDeliveryPage extends StatefulWidget {
  @override
  _CashOnDeliveryPageState createState() => _CashOnDeliveryPageState();
}

class _CashOnDeliveryPageState extends State<CashOnDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CashOnDeliveryAppBar(),
      body: Body(),
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
            SizedBox(
                height: 5
            ),
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
            SizedBox(height: 10.0,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: NPrimaryColor,
                onPressed: ()async {
                  AddOrderResponse response = await checkoutBloc.createOrder();
                  if(response.error==null)
                    Navigator.of(context).pushNamed("orderConfirmationPage");
                },
                child: Text(
                  "Confirm Order", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
