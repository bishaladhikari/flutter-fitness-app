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
  Address address;

  @override
  void initState() {
    checkoutBloc.getDefaultAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black.withOpacity(.01),
        child: Column(
          children: [
            address == null ? AddAddress() : Container(),
            Text("Shipping Address"),
            SizedBox(
              height: 10.0,
            ),
            AddressListItem(
              address: address,
            )
          ],
        ),
      ),
    );
  }
}
