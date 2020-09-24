import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/home/components/products_list.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';

import 'package:easy_localization/easy_localization.dart';

import 'category_list.dart';
import 'discount_card.dart';
import 'featured_products_list.dart';
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "featured_products".tr().toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
            ),
          ),
          FeaturedProductsList(),
          SizedBox(height: 5),
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
          ),

        ],
      ),
    );
  }
}
