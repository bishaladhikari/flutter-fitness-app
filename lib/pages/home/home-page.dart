import 'package:flutter/material.dart';
import 'package:ecapp/components/bottom_nav_bar.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.01),
      appBar: homeAppBar(context),
//      bottomNavigationBar: BottomNavBar(),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
