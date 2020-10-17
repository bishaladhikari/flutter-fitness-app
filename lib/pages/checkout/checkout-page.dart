import 'package:ecapp/constants.dart';
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
      appBar: CheckoutAppBar(),
      body: Body(),
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
                  "Total Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
                Spacer(),
                Text(
                  "Rs 4,201",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: NPrimaryColor,
                      fontSize: 16),
                ),
                Spacer(),
                FlatButton(
                  onPressed:(){},
                  color: NPrimaryColor,
                  child: Text("Proceed to Pay",style: TextStyle(color: Colors.white),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
