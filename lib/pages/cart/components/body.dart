import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rakurakubazzar/bloc/cart_bloc.dart';
import 'package:rakurakubazzar/components/custom_error_widget.dart';
import 'package:rakurakubazzar/components/no_internet_widget.dart';
import 'package:rakurakubazzar/models/cart.dart';
import 'package:rakurakubazzar/models/cart_item.dart';
import 'package:rakurakubazzar/models/promotion_item.dart';
import 'package:rakurakubazzar/models/response/cart_response.dart';
import 'package:rakurakubazzar/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants.dart';
import 'cart_item_view.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ),
    );
  }

  Widget _buildCartWidget(context, CartResponse data) {
    List<Cart> carts = data.carts;
    final cartChildren = <Widget>[];

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
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: itemChildren),
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
      child: Column(
        children: [
          FlatButton(
            color: kPrimaryColor,
            onPressed: () {
              showMaterialModalBottomSheet(
                  expand: false,
                  bounce: true,
                  context: context,
                  builder: (context, scrollController) {
                    return _showPromotion(context);
                  });
            },
            child: Text(
              tr('Claimed! offer under promotion for anywhere'),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartChildren),
        ],
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
          tr('Spend ¥500 and ¥10 enjoy Cash Discount offer under Special promotions promotion for anywhere',
              namedArgs: {
                'minimumRequirement':
                    promotionItem.minimumRequirement.toString(),
                'discount': promotionItem.discount.toString()
              }),
          style: TextStyle(color: NPrimaryColor)),
    );
  }

  _showPromotion(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return CustomErrorWidget(snapshot.data.error);
              }
              return _platformPromotion(context, snapshot.data);
            } else {
              return Container();
            }
          }),
    );
  }

  Widget _platformPromotion(context, CartResponse data) {
    List<PromotionItem> platformPromotions = data.platformPromotions;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            tr('Platform Promotion'),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: kPrimaryColor),
          )),
          Column(
            children: platformPromotions.map((promotion) {
              return _buildPlatformPromotionWidget(promotion);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformPromotionWidget(platformPromotion) {
    return Container(
      child: Text(
          tr('Spend ¥500 and ¥10 enjoy Cash Discount offer under Special promotions promotion for anywhere',
              namedArgs: {
                'minimumRequirement':
                    platformPromotion.minimumRequirement.toString(),
                'discount': platformPromotion.type == 'Free Shipping'
                    ? platformPromotion.type
                    : platformPromotion.discount.toString()
              }),
          style: TextStyle(color: NPrimaryColor)),
    );
  }
}
