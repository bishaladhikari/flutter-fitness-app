import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: checkoutAppBar(),
      body: Body(),
      bottomNavigationBar: StreamBuilder<CartResponse>(
          stream: cartBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var cartSummary = snapshot.data.cartSummary;
              return GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: _showCartSummary(cartSummary,context),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 160,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Text(tr("View more info"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          // IconButton(
                          //     icon: Icon(
                          //   Icons.keyboard_arrow_up_outlined,
                          //   size: 25,
                          // ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tr('Subtotal'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black)),
                          Text('¥ ' + checkoutBloc.finalTotalAmount.toString(),
                              style: TextStyle(
                                  // color: NPrimaryColor,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black,
                                  fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(tr('Total Amount'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text('¥ ' + checkoutBloc.finalTotalAmount.toString(),
                              style: TextStyle(
                                  color: NPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder<Address>(
                          stream: addressBloc.defaultAddress,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  color: NPrimaryColor,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "selectPaymentMethodPage");
                                  },
                                  child: Text(tr('Proceed to Pay'),
                                      style: TextStyle(color: Colors.white)),
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  color: NPrimaryColor,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'addressFormPage');
                                  },
                                  child: Text(tr('Add Address'),
                                      style: TextStyle(color: Colors.white)),
                                ),
                              );
                            }
                          }),

                    ],
                  ),
                ),
              );
            } else
              return Container();
          }),
    );
  }

  _showCartSummary(cartSummary,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          Navigator.pop(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Text(tr("View less info"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                // IconButton(
                //     icon: Icon(
                //       Icons.keyboard_arrow_down_outlined,
                //       size: 25,
                //     ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr('Total items'),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black)),
                Text(cartSummary.totalItems.toString(),
                    style: TextStyle(
                      // color: NPrimaryColor,
                        fontWeight: FontWeight.w400,
                        color:Colors.black,
                        fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr('Total Weight'),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black)),
                Text(cartSummary.totalWeight.toString(),
                    style: TextStyle(
                      // color: NPrimaryColor,
                        fontWeight: FontWeight.w400,
                        color:Colors.black,
                        fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr('Subtotal'),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black)),
                Text('¥ ' + checkoutBloc.finalTotalAmount.toString(),
                    style: TextStyle(
                      // color: NPrimaryColor,
                        fontWeight: FontWeight.w400,
                        color:Colors.black,
                        fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr('Discount Amount'),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black)),
                Text('¥ ' + cartSummary.bulkDiscountCost.toString(),
                    style: TextStyle(
                      // color: NPrimaryColor,
                        fontWeight: FontWeight.w400,
                        color:Colors.black,
                        fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(tr('Total Amount'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text('¥ ' + checkoutBloc.finalTotalAmount.toString(),
                    style: TextStyle(
                        color: NPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            StreamBuilder<Address>(
                stream: addressBloc.defaultAddress,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: NPrimaryColor,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "selectPaymentMethodPage");
                        },
                        child: Text(tr('Proceed to Pay'),
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: NPrimaryColor,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'addressFormPage');
                        },
                        child: Text(tr('Add Address'),
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }
                }),

          ],
        ),
      ),
    );
  }
}
