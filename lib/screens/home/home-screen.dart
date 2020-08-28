import 'package:flutter/material.dart';
import 'package:ecapp/components/bottom_nav_bar.dart';
import 'package:ecapp/screens/home/components/app_bar.dart';
import 'package:ecapp/screens/home/components/body.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: BottomNavBar(),
      body: Body(
        
      ),


      
    );
  }
}
