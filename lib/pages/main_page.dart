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
  List<Widget> _screens = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    AccountPage()
  ];

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
      drawer: Drawer(child : leftDrawerMenu()),
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
              icon: currentPage == 0
                  ? SvgPicture.asset("assets/icons/home.svg",
                      color: NPrimaryColor)
                  : SvgPicture.asset("assets/icons/home_outline.svg"),
              padding: EdgeInsets.all(15),
              onPressed: () => {
                _changePage(0),
              },
            ),
            IconButton(
              icon: currentPage == 1
                  ? SvgPicture.asset("assets/icons/category.svg",
                      color: NPrimaryColor)
                  : SvgPicture.asset("assets/icons/Category_Out_bold.svg"),
              padding: EdgeInsets.all(15),
              onPressed: () => {_changePage(1)},
            ),
            IconButton(
              icon: Stack(
                children: [
                  currentPage == 2
                      ? SvgPicture.asset("assets/icons/Cart_03.svg",
                          color: NPrimaryColor)
                      : SvgPicture.asset("assets/icons/Cart_02.svg"),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 14, top: 0, bottom: 14),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Text(
                        cart_count.toString(),
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              onPressed: () => {_changePage(2)},
            ),
            IconButton(
              padding: EdgeInsets.all(10),
              icon: currentPage == 3
                  ? SvgPicture.asset("assets/icons/p.svg", color: NPrimaryColor)
                  : SvgPicture.asset("assets/icons/person.svg"),
              onPressed: () => {_changePage(3)},
            ),
          ],
        ),
      ),
    );
  }
}

leftDrawerMenu() {
  Color blackColor = Colors.black.withOpacity(0.6);
  return Container(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          height: 150,
          child: DrawerHeader(
            child: ListTile(
              trailing: Icon(
                Icons.chevron_right,
                size: 28,
              ),
              subtitle: GestureDetector(
                onTap: () {
                },
                child: Text(
                  "See Profile",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor),
                ),
              ),
              title: Text(
                "Ali Anıl Koçak",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFB),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: kPrimaryColor,
          ),
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: kPrimaryColor),
          ),
          onTap: () {
          },
        ),
        ListTile(
          trailing: Icon(
            Icons.home,
            color: Color(0xFFFB7C7A),
            size: 18,
          ),
          leading: Icon(Icons.home, color: ksecondaryColor),
          title: Text('My orders',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor)),
          onTap: () {
          },
        ),
        ListTile(
          leading: Icon(Icons.home, color: ksecondaryColor),
          title: Text('Search',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor)),
          onTap: () {
          },
        ),
        ListTile(
          trailing: Icon(
            Icons.home,
            color: Color(0xFFFB7C7A),
            size: 18,
          ),
          leading: Icon(Icons.home, color: ksecondaryColor),
          title: Text('Notifications',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor)),
          onTap: () {

          },
        ),
//        ListTile(
//          trailing: Icon(
//            Icons.looks_two,
//            color: Color(0xFFFB7C7A),
//            size: 18,
//          ),
//          leading:
//          Icon(Feather.getIconData('shopping-cart'), color: blackColor),
//          title: Text('Shopping Cart',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Navigator.push(
//              context,
//              PageTransition(
//                type: PageTransitionType.fade,
//                child: ShoppingCart(true),
//              ),
//            );
//          },
//        ),
//        ListTile(
//          leading: Icon(Feather.getIconData('list'), color: blackColor),
//          title: Text('My Orders',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Nav.route(context, ProductList());
//          },
//        ),
//        ListTile(
//          leading: Icon(Feather.getIconData('award'), color: blackColor),
//          title: Text('Points',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Nav.route(context, Checkout());
//          },
//        ),
//        ListTile(
//          leading:
//          Icon(Feather.getIconData('message-circle'), color: blackColor),
//          title: Text('Support',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Nav.route(context, ProductList());
//          },
//        ),
//        ListTile(
//          leading:
//          Icon(Feather.getIconData('help-circle'), color: blackColor),
//          title: Text('Help',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Nav.route(context, UserSettings());
//          },
//        ),
//        ListTile(
//          leading: Icon(Feather.getIconData('settings'), color: blackColor),
//          title: Text('Settings',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            Navigator.push(
//              context,
//              PageTransition(
//                type: PageTransitionType.fade,
//                child: UserSettings(),
//              ),
//            );
//          },
//        ),
//        ListTile(
//          leading: Icon(Feather.getIconData('x-circle'), color: blackColor),
//          title: Text('Quit',
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w600,
//                  color: blackColor)),
//          onTap: () {
//            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//          },
//        ),
      ],
    ),
  );
}

