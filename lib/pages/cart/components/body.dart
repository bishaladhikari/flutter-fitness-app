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
                  return _buildErrorWidget(context,snapshot.data.error);
                }
                return _buildCartWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(context,snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }),
//        Container(
//          padding: EdgeInsets.all(8.0),
//          child: Row(
//            mainAxisSize: MainAxisSize.max,
//            children: [
//              Container(
//                height: 83.5,
//                color: Colors.white,
//                child: Center(
//                  child: Text('Total',
//                      style: TextStyle(
//                          fontFamily: 'Quicksand',
//                          fontWeight: FontWeight.bold,
//                          color: Colors.black)),
//                ),
//              ),
//              Container(
//                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 27),
////                          height: 50,
//                  color: Colors.white,
//                  width: 200,
//                  child: Container(
////                                height: 50,
//                    width: double.infinity,
////                        decoration: ,
//                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//                    child: Center(
//                      child: Text('Rs ' + '1000',
//                          style: TextStyle(color: Colors.black, fontSize: 15)),
//                    ),
//                  ))
//            ],
//          ),
//        ),
//        Padding(
//          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//          child: Container(
//            width: double.infinity,
//            height: 50,
//            child: RaisedButton(
//              color: NPrimaryColor,
//              onPressed: () {},
//              child: Text('Checkout', style: TextStyle(color: Colors.white)),
//            ),
//          ),
//        )
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
                      fontFamily: 'Quicksand',
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

  Widget _buildErrorWidget(context,String error) {
//    return Center(
//        child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        Text("Error occurred: $error"),
//      ],
//    ));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("$error"),
    ));
  }
}
