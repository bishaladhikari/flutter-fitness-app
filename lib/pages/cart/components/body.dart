import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/components/custom_error_widget.dart';
import 'package:ecapp/components/no_internet_widget.dart';
import 'package:ecapp/models/cart.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'cart_item_view.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
    final cartChildren = <Widget>[];
    for (int i = 0; i < carts?.length ?? 0; i++) {
      List<CartItem> cartItems = carts[i].items;
      int itemCount = cartItems.length;
      final itemChildren = <Widget>[];
      for (int i = 0; i < cartItems?.length ?? 0; i++) {
        itemChildren.add(CartItemView(cartItem: cartItems[i]));
      }
      cartChildren.add(Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "storePage",arguments: carts[i].storeSlug);
                },
                child: Row(children: [
                  Text(
                    carts[i].soldBy + " ($itemCount items)",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                ]),
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
                  "There are no items in this cart",
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
                  child: Text("CONTINUE SHOPPING"),
                )
              ],
            ),
          ),
        ),
      );
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: cartChildren),
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
      return NoInternetWidget();
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }
}
