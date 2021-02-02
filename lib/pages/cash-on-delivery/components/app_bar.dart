import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

AppBar cashOnDeliveryAppBar() {
  return AppBar(
    backgroundColor: Colors.white,

    elevation: 1,
    title: Text(tr("Cash On Delivery")),
  );
}
