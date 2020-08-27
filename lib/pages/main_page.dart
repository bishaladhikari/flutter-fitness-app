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

  void onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/home.svg"),
              title: Text("")
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Following.svg"),
              title: Text("")
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Glyph.svg"),
              title: Text("")
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/person.svg"),
              title: Text("")
          )
        ],
      ),
    );
  }
}
