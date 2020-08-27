import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Offers & Discounts",
            style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
          ),
//          DiscountCard(),
        ],
      ),
    );
  }
}
