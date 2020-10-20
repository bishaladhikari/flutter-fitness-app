import 'package:ecapp/models/address.dart';
import 'package:ecapp/pages/account/account-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressListItem extends StatelessWidget {
  Address address;
  AddressListItem({
    Key key,
    this.address
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 5.0,vertical: 5),
            child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Icon(
                      Icons.add_location,
                      color: Colors.orange,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name.toString(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16),
                      ),
                      Text(address.phone.toString(),
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14)),
                      Text(address.house.toString(),
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14)),
                      Text(address.city.toString(),
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14)),
                    ],
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, 'addressFormPage',
                          arguments: address);
                    },
                    // padding: const EdgeInsets.fromLTRB(180, 0, 30, 0),
                    child: Text(
                      "Edit",
                      style: TextStyle(
//                                                decoration:
//                                                TextDecoration.underline,
                          color: Colors.lightBlue,
                          fontSize: 15),
                    ),
                  ),
                ])),
      ],
    );
  }
}
