import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/models/cart.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  return _buildErrorWidget(context, snapshot.data.error);
                }
                return _buildCartWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(context, snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }),
      ],
    );
  }

  Widget _buildCartWidget(CartResponse data) {
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
              child: Row(children: [
                Text(
                  carts[i].soldBy + " ($itemCount items)",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
            margin: const EdgeInsets.only(top:50),
            child: Column(
              children: [
                Text("There are no items in this cart",style: TextStyle(color: Colors.black87),),
                SizedBox(height: 8.0,),
                FlatButton(
                  onPressed: () {},
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
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  Widget _buildErrorWidget(context, String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("$error"),
    ));
  }
}
