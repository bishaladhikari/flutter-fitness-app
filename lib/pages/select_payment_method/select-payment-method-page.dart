import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  @override
  _SelectPaymentMethodPageState createState() => _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectPaymentMethodAppBar(),
      body: SelectPaymentBody(),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 80,
        child: Column(
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
              height:5
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
            )
          ],
        ),
      ),
    );
  }
}
