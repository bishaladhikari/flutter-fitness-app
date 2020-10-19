import 'package:ecapp/components/search_box.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBox(),
      ),
//      appBar: homeAppBar(context),
//      bottomNavigationBar: BottomNavBar(),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
