import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/home/components/products_list.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';

import 'package:easy_localization/easy_localization.dart';

import 'category_list.dart';
import 'discount_card.dart';
import 'item_list.dart';

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
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Text(
//              "featured_products".tr().toString(),
//              style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
//            ),
//          ),
//          RaisedButton(
//            child: Text('English'),
//            onPressed:() {
//              EasyLocalization.of(context).locale = Locale('en','US');
//            },
//          ),
//          RaisedButton(
//            child: Text('japanese'),
//            onPressed:() {
//              EasyLocalization.of(context).locale = Locale('vi','VN');
//            },
//          ),
//          ItemList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "products_for_you".tr().toString(),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: kTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: ProductsList(),
          )
        ],
      ),
    );
  }
}
