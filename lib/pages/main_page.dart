import 'package:ecapp/pages/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'account/account-page.dart';
import 'cart/cart_page.dart';
import 'category/category_page.dart';
import 'package:ecapp/constants.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [HomePage(), CategoryPage(), CartPage() , AccountPage()];

  void _onPageChanged(int index) {}
  int currentPage = 0;
  int cart_count = 0;
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
              icon: currentPage == 0 ? SvgPicture.asset("assets/icons/home.svg", color: NPrimaryColor) : SvgPicture.asset("assets/icons/home_outline.svg"),
              padding: EdgeInsets.all(15),
              onPressed: () => {
                _changePage(0),
              },

            ),
            IconButton(
              icon: currentPage == 1 ? SvgPicture.asset("assets/icons/category.svg", color: NPrimaryColor) : SvgPicture.asset("assets/icons/Category_Out_bold.svg"),
              padding: EdgeInsets.all(15),
              onPressed: () => {
                _changePage(1)
              },
            ),
            IconButton(
              icon: Stack(
                  children: [
                  currentPage == 2? SvgPicture.asset("assets/icons/Cart_03.svg", color: NPrimaryColor) : SvgPicture.asset("assets/icons/Cart_02.svg"),
                  Expanded(

                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 14, top:0, bottom: 14),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange
                      ),
                      child: Text(cart_count.toString(), style: TextStyle(fontSize: 10, color: Colors.white),),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),

              onPressed: () => {_changePage(2)},
            ),
            IconButton(
              padding: EdgeInsets.all(10),
              icon:  currentPage == 3 ? SvgPicture.asset("assets/icons/p.svg", color: NPrimaryColor) : SvgPicture.asset("assets/icons/person.svg"),
              onPressed: () => {_changePage(3)},
            ),
          ],
        ),
      ),
    );
  }
}
