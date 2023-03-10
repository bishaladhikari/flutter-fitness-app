import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/address_bloc.dart';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/bloc/checkout_bloc.dart';
import 'package:fitnessive/components/add_address.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/address.dart';
import 'package:fitnessive/models/cart.dart';
import 'package:fitnessive/models/cart_item.dart';
import 'package:fitnessive/models/response/cart_response.dart';
import 'package:fitnessive/pages/checkout/components/checkout_cart_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';

import 'checkout_address_list_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // checkoutBloc.getDefaultAddress();
    cartBloc.getCart();
    super.initState();
  }

  @override
  void dispose() {
    checkoutBloc..drainStream();
    checkoutBloc..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black.withOpacity(.01),
          height: 200,
          child: Column(
            children: [
              StreamBuilder<Address>(
                  stream: addressBloc.defaultAddress,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("defaultAddress"+jsonEncode(snapshot.data));
                      return _buildAddressWidget(snapshot.data);
                    }
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (!snapshot.hasData) {
                    //     Scaffold.of(context).showSnackBar(SnackBar(
                    //       content:
                    //           Text(tr("Please provide a shipping address.")),
                    //       backgroundColor: Colors.redAccent,
                    //     ));
                    //   }
                    // });
                    return AddAddress();
                  }),
            ],
          ),
        ),
        _buildCartListWidget()
      ],
    );
  }

  Widget _buildCartListWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
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

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              strokeWidth: 4.0,
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildAddressWidget(Address address) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  tr("Shipping Address"),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          CheckoutAddressListItem(
            address: address,
            selectMode: true,
          )
        ],
      ),
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
        itemChildren.add(CheckoutCartItemView(cartItem: cartItems[i]));
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
                child: Row(children: [
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
                Text(tr("There are no items in this cart")),
                SizedBox(
                  height: 8.0,
                ),
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

  Widget _buildErrorWidget(context, String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("$error"),
    ));
  }
}
