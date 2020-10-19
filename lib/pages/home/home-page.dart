import 'package:ecapp/components/search_box.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/bottom_nav_bar.dart';

import '../main_page.dart';
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
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            IconButton(
                icon: Icon(Icons.menu,),
                onPressed: () {
                  MainPage.of(context).scaffoldKey.currentState.openDrawer();
                }
            ),
            SearchBox()
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
//      appBar: homeAppBar(context),
//      bottomNavigationBar: BottomNavBar(),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
