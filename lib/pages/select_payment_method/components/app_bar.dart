import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

AppBar selectPaymentMethodAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(tr("Select Payment Method"),style: TextStyle(fontSize: 16),),
  );
}
