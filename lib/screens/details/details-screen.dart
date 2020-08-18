import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/screens/details/components/app_bar.dart';
import 'package:ecapp/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(),
      body: Body(),
    );
  }
}
