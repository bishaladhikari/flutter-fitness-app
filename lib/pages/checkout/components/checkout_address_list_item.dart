import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/models/address.dart';
import 'package:flutter/material.dart';

class CheckoutAddressListItem extends StatefulWidget {
  Address address;
  bool selectMode;

  CheckoutAddressListItem({Key key, this.address, this.selectMode})
      : super(key: key);

  @override
  _CheckoutAddressListItemState createState() =>
      _CheckoutAddressListItemState();
}

class _CheckoutAddressListItemState extends State<CheckoutAddressListItem> {
  bool selectMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.add_location,
                      color: Colors.orange,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.address.name.toString(),
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      Text(widget.address.phone.toString(),
                          style:
                              TextStyle(color: Colors.black38, fontSize: 14)),
                      Text(widget.address.house.toString(),
                          style:
                              TextStyle(color: Colors.black38, fontSize: 14)),
                      Text(widget.address.city.toString(),
                          style:
                              TextStyle(color: Colors.black38, fontSize: 14)),
                    ],
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'addressPage',
                          arguments: true);
                    },
                    child: Text(
                      tr("Change"),
                      style: TextStyle(color: Colors.lightBlue, fontSize: 15),
                    ),
                  )
                ])),
      ],
    );
  }
}
