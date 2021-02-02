import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/wishlist_bloc.dart';
import 'package:ecapp/components/custom_error_widget.dart';
import 'package:ecapp/components/no_internet_widget.dart';
import 'package:ecapp/models/cart.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/pages/wish/wish_item_view.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class WishListPage extends StatefulWidget {
  WishListPage() {
//    authBloc.isAuthenticated==false
//        Navigator.of(context,rootNavigator: true).push("/loginPage")
  }

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    super.initState();
    wishListBloc.getWishlist();
  }

  @override
  void dispose() {
    super.dispose();
    wishListBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("WishList")),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<WishlistResponse>(
          stream: wishListBloc.subject.stream,
          builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return CustomErrorWidget(snapshot.data.error);
                }
                return _buildWishlistWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return CustomErrorWidget(snapshot.error);
              }
            return _buildLoadingWidget();
          }),
      // body: Center(
      //   child: Text("I am wish list page"),
      // ),
    );
  }

  Widget _buildWishlistWidget(WishlistResponse data) {
    List<Cart> carts = data.wishes;
    final cartChildren = <Widget>[];
    for (int i = 0; i < carts?.length ?? 0; i++) {
      List<CartItem> cartItems = carts[i].items;
      int itemCount = cartItems.length;
      final itemChildren = <Widget>[];
      for (int i = 0; i < cartItems?.length ?? 0; i++) {
        itemChildren.add(WishItemView(cartItem: cartItems[i]));
      }
      cartChildren.add(Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: (){
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
                  "There are no items in your wishlist.",
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(
                  height: 8.0,
                ),
                FlatButton(
                  onPressed: () {
                    // MainPage.of(context).changePage(0);
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
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: cartChildren),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
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

  Widget _buildErrorWidget(String error) {
    if (error == "No internet connection")
      return NoInternetWidget();
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }
}

/// This is the stateless widget that the main application instantiates.

class ListTileItem extends StatelessWidget {
  final leading;
  final title;
  final subtitle;

  ListTileItem({this.leading, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Container(
          height: 50.0,
          width: 50.0,
          child: CachedNetworkImage(imageUrl: leading),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title), Text(subtitle)]),
        )
      ]),
    );
  }
}
