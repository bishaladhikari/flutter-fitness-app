import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/components/bottom_nav_bar.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.01),
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'My Cart',
          style:
              TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(child: CartBody()),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double totalAmount =snapshot.data.totalAmount;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                height: 75,
                width: double.infinity,
                // double.infinity means it cove the available width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -7),
                      blurRadius: 33,
                      color: Color(0xFF6DAED9).withOpacity(0.11),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text('¥ ' + totalAmount.toString(),
                        style: TextStyle(color: NPrimaryColor, fontSize: 15)),
                    RaisedButton(
                      color: NPrimaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, "checkoutPage");
                      },
                      child: Text('Checkout', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }
            else return Container();
          }),
      );
  }

  @override
  bool get wantKeepAlive => true;
}