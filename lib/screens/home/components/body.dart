import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';
import 'package:ecapp/screens/home/components/category_list.dart';
import 'package:ecapp/screens/home/components/discount_card.dart';
import 'package:ecapp/screens/home/components/item_list.dart';
import 'package:easy_localization/easy_localization.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchBox(
            onChanged: (value) {},
          ),
          CategoryList(),
          DiscountCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "featured_products".tr().toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
            ),
          ),
          RaisedButton(
            child: Text('English'),
            onPressed:() {
              EasyLocalization.of(context).locale = Locale('en','US');
            },
          ),
          RaisedButton(
            child: Text('japanese'),
            onPressed:() {
              EasyLocalization.of(context).locale = Locale('vi','VN');
            },
          ),
          ItemList(),
        ],
      ),
    );
  }
}
