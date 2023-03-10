import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/address_bloc.dart';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/models/response/address_response.dart';
import 'package:fitnessive/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../main_page.dart';
import 'components/body.dart';
import 'package:fitnessive/bloc/checkout_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    super.dispose();
    cartBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('My Cart'),
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            MainPage.of(context).scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
        actions: [],
      ),
      body: CartBody(),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.carts.length == 0) return Text("");
              double totalAmount = snapshot.data.cartSummary.totalAmount;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                height: 75,
                width: double.infinity,
                // double.infinity means it cove the available width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
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
                    Expanded(
                      child: Row(
                        children: [
                          Text(tr('Total Amount'),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(' ?? ' + checkoutBloc.totalAmount.toString(),
                              style: TextStyle(
                                  color: NPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    RaisedButton(
                      color: NPrimaryColor,
                      onPressed: () {
                        getDefaultAddress(context);
                      },
                      child: Text(tr('Checkout'),
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }

  getDefaultAddress(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  color: Colors.white,
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator()),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Material(
                          child: Text(
                            tr("Checking out"),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )));
    AddressResponse response = await addressBloc.getAddresses();
    Navigator.pop(context);
    if (response.error != null) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(tr(response.error)),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      Navigator.pushNamed(context, "checkoutPage")
          .then((value) => {cartBloc.getCart()});
    }
  }

  @override
  bool get wantKeepAlive => true;
}
