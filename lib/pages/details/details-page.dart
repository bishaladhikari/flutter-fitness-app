import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(),
      body: Body(),
    );
  }
}
