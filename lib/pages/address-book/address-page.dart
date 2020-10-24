import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/components/add_address.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/pages/address-book/address_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddressPage extends StatefulWidget {
  bool selectMode;

  AddressPage({Key key, this.selectMode}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool selectMode;

  @override
  Widget build(BuildContext context) {
    addressBloc.getAddresses();
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            ' My Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            AddAddress(),
            StreamBuilder(
                stream: addressBloc.addresses,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.addresses.isNotEmpty) {
                    List<Address> addresses = snapshot.data.addresses;
                    return ListView.builder(
                        itemCount: snapshot.data.addresses.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          Address address = snapshot.data.addresses[index];
                          return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                if (widget.selectMode) {
                                  checkoutBloc.setDefaultAddress(address);
                                  Navigator.pop(context);
                                }
                              },
                              child: AddressListItem(
                                  address: address,
                                  selectMode: widget.selectMode));
                        });
                  }
                  return Container();
                }),
          ]),
        ));
  }
}
