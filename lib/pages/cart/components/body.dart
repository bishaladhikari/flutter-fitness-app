import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/components/custom_error_widget.dart';
import 'package:ecapp/components/no_internet_widget.dart';
import 'package:ecapp/models/cart.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/promotion_item.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'cart_item_view.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<CartResponse>(
            stream: cartBloc.subject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return CustomErrorWidget(snapshot.data.error);
                }
                return _buildCartWidget(context, snapshot.data);
              } else if (snapshot.hasError) {
                return CustomErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }),
      ],
    );
  }

  Widget _buildCartWidget(context, CartResponse data) {
    List<Cart> carts = data.carts;
    List<PromotionItem> platformPromotions = data.platformPromotions;
    final cartChildren = <Widget>[];
    final platformPromotionChildren = <Widget>[];
    for (int i = 0; i < platformPromotions?.length ?? 0; i++) {
      platformPromotionChildren
          .add(_buildPlatformPromotionWidget(platformPromotions[i]));
    }

    for (int i = 0; i < carts?.length ?? 0; i++) {
      List<CartItem> cartItems = carts[i].items;
      List<PromotionItem> promotionItems = carts[i].promotions;
      int itemCount = cartItems.length;
      final itemChildren = <Widget>[];
      for (int i = 0; i < cartItems?.length ?? 0; i++) {
        itemChildren.add(CartItemView(cartItem: cartItems[i]));
      }
      final promotionChildren = <Widget>[];
      for (int p = 0; p < promotionItems?.length ?? 0; p++) {
        promotionChildren.add(_buildPromotionWidget(promotionItems[p]));
      }
      cartChildren.add(Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "storePage",
                    arguments: carts[i].storeSlug);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        carts[i].soldBy + " ($itemCount items)",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: promotionChildren,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itemChildren),
          ),
        ],
      ));
    }
    if (carts.length == 0)
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  tr("There are no items in this cart"),
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(
                  height: 8.0,
                ),
                FlatButton(
                  onPressed: () {
                    MainPage.of(context).changePage(0);
                  },
                  color: NPrimaryColor,
                  textColor: Colors.white,
                  child: Text(tr("CONTINUE SHOPPING")),
                )
              ],
            ),
          ),
        ),
      );

    return Container(
      child: Container(
        child: Column(
          children: [
            ExpansionTile(
              title: Expanded(
                child: Text(
                  tr('Claimed! offer under promotion for anywhere'),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              childrenPadding: const EdgeInsets.only(
                  top: 0.0, left: 15, right: 0.0, bottom: 10.0),
              children: platformPromotionChildren,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cartChildren),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(context, String error) {
    if (error == "No internet connection")
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoInternetWidget(),
          ],
        ),
      );
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildPromotionWidget(promotionItem) {
    return Container(
      child: Text(
          tr("Spend ¥500 and ¥10 enjoy Cash Discount offer under Special promotions promotion for anywhere"),
          style: TextStyle(color: NPrimaryColor)),
      // Text(
      //   tr('Spend ¥ ') +
      //       promotionItem.minimumRequirement.toString() +
      //       tr(' and ¥ ') +
      //       promotionItem.discount.toString() +
      //       tr(' enjoy ') +
      //       promotionItem.type +
      //       tr(' under ') +
      //       promotionItem.title +
      //       tr(' promotion for anywhere'),
      //   style: TextStyle(color: NPrimaryColor),
      // ),
    );
  }

  Widget _buildPlatformPromotionWidget(platformPromotion) {
    return Container(
      child: Text(
        tr("Spend ¥500 and ¥10 enjoy Cash Discount offer under Special promotions promotion for anywhere"),
        style: TextStyle(color: NPrimaryColor),
      ),
    );
  }
}
