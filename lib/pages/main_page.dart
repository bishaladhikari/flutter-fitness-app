import 'package:ecapp/pages/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'account/account-page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [HomePage(), AccountPage()];

  void _onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        height: 75,
        width: double.infinity,
        // double.infinity means it cove the available width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -7),
              blurRadius: 33,
              color: Color(0xFF6DAED9).withOpacity(0.11),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset("assets/icons/home.svg"),
              onPressed: () => {_pageController.jumpToPage(0)},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/Following.svg"),
              onPressed: () => {_pageController.jumpToPage(1)},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/Glyph.svg"),
              onPressed: () => {_pageController.jumpToPage(1)},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/person.svg"),
              onPressed: () => {_pageController.jumpToPage(1)},
            ),
          ],
        ),
      ),
    );
  }
}
