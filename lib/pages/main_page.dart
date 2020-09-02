import 'package:ecapp/pages/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'account/account-page.dart';
import 'cart/cart_page.dart';
import 'category/category_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [HomePage(), CategoryPage(), CartPage() , AccountPage()];

  void _onPageChanged(int index) {}
  int currentPage = 0;
  void _changePage(id) {
    setState(() {
      _pageController.jumpToPage(id);
      currentPage = id;
    });
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
              icon: currentPage == 0 ? SvgPicture.asset("assets/icons/home.svg") : SvgPicture.asset("assets/icons/home_faded.svg"),
//              icon: Icon(Icons.home),
              onPressed: () => {
                _changePage(0),
              },

            ),
            IconButton(
              icon: currentPage == 1 ? SvgPicture.asset("assets/icons/category.svg") : SvgPicture.asset("assets/icons/category_out.svg"),
              padding: EdgeInsets.all(15),
              onPressed: () => {
                _changePage(1)
              },
            ),
            IconButton(
              icon: currentPage == 2? SvgPicture.asset("assets/icons/Cart.svg") : SvgPicture.asset("assets/icons/Cart_Out.svg"),
              padding: EdgeInsets.all(10),

              onPressed: () => {_changePage(2)},
            ),
            IconButton(
              icon:  currentPage == 3 ? SvgPicture.asset("assets/icons/person_selected.svg") : SvgPicture.asset("assets/icons/person.svg"),
              onPressed: () => {_changePage(3)},
            ),
          ],
        ),
      ),
    );
  }
}
