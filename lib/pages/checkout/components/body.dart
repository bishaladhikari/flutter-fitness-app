import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/components/add_address.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/pages/address-book/address_list_item.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
//  Address address;

  @override
  void initState() {
    checkoutBloc.getDefaultAddress();
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
    return SingleChildScrollView(
      child: Container(
        color: Colors.black.withOpacity(.01),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<Address>(
                stream: checkoutBloc.defaultAddress,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null)
                      return _buildAddressWidget(snapshot.data);
                    else
                      return AddAddress();
                  }
                  return _buildLoadingWidget();
                  return AddAddress();
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
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
      )),
    );
  }

  Widget _buildAddressWidget(Address address) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Shipping Address",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          AddressListItem(
            address: address,
          )
        ],
      ),
    );
  }
}
