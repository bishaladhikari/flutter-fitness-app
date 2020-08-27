import 'package:flutter/material.dart';
import 'package:ecapp/components/bottom_nav_bar.dart';

import 'components/app_bar.dart';
import 'components/body.dart';


class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: BottomNavBar(),
      body: Body(),
    );
  }
}
