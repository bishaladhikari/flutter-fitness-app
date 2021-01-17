import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/components/add_address.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/pages/address-book/address_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressPage extends StatefulWidget {
  bool selectMode;

  AddressPage({Key key, this.selectMode}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  @override
  Widget build(BuildContext context) {
    addressBloc.getAddresses();
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            widget.selectMode?tr('Select Address'):tr('My Address'),
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            AddAddress(),
            StreamBuilder(
                stream: addressBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Address> addresses = snapshot.data.addresses;
                    return ListView.builder(
                        itemCount: snapshot.data.addresses.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          Address address = snapshot.data.addresses[index];
                          return InkWell(
                              // behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                if (widget.selectMode) {
                                  var response = await addressBloc.setDefaultAddress(address);
                                  if(response.error == null){
                                    await cartBloc.getCartSummary();
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: AddressListItem(
                                  address: address));
                        });
                  }
                  return Container();
                }),
          ]),
        ));
  }
}
