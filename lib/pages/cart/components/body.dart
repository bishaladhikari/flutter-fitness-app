import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/models/cart.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import 'cart_item_view.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List cart = [
    {
      'name': 'Cabbage goes the long way',
      'price': 'Rs 100',
      'image':
          'https://img2.pngio.com/cheese-pizza-png-clip-art-library-plain-pizza-png-920_805.png',
      'count': 1
    },
    {
      'name': 'Tomato',
      'price': 'Rs 50',
      'image':
          'https://pngimg.com/uploads/burger_sandwich/burger_sandwich_PNG4135.png',
      'count': 5
    },
    {
      'name': 'Potato',
      'price': 'Rs 250',
      'image':
          'https://lh3.googleusercontent.com/proxy/RmSFgLUs1MO_dQxup3bjAo9SCeo5kBup11gBI5Kqm-269CCqKfMouHQET1RULWXV1j6Nia5tzt4-dxzKoXI2CpG5e2N0W-zoRXG3vfKBJ6R-c5w6VAHCJDbssQ',
      'count': 2
    },
  ];

  // @override
  subCount(i) {
    setState(() {
      cart[i]['count']--;
    });
  }

  incCount(i) {
    setState(() {
      cart[i]['count']++;
    });
  }

  @override
  void initState() {
    super.initState();
    print(cart.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<CartResponse>(
            stream: cartBloc.subject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildCartWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }),
        Container(
          padding: EdgeInsets.only(bottom: 1),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 83.5,
                color: Colors.white,
                child: Center(
                  child: Text('Total',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 27),
//                          height: 50,
                  color: Colors.white,
                  width: 200,
                  child: Container(
//                                height: 50,
                    width: double.infinity,
//                        decoration: ,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    child: Center(
                      child: Text('Rs ' + '1',
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Container(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              color: NPrimaryColor,
              onPressed: () {},
              child: Text('Checkout', style: TextStyle(color: Colors.white)),
            ),
          ),
        )
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: [
                Text(
                  "Sold By: " + carts[i].soldBy + " ($itemCount items)",
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

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }
}
