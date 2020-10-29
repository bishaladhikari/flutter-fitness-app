import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/categories_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/pages/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'account/account-page.dart';
import 'cart/cart-page.dart';
import 'category/category_page.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';

//import 'package:path/path.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

  static _MainPageState of(BuildContext context) {
    final _MainPageState navigator =
        context.ancestorStateOfType(const TypeMatcher<_MainPageState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a MainPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    categoryBloc..getCategories();
    productsBloc..getFeaturedProducts();
    productsBloc..getProducts();
    productsBloc..getNewArrivals();
    cartBloc..getCart();
//    comboBloc.getComboProducts();
  }

  @override
  void dispose() {
    super.dispose();
    productsBloc..dispose();
  }

  PageController _pageController = PageController();
  List<Widget> _screens = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    AccountPage()
  ];

  void _onPageChanged(int index) {
    if (index == 2) cartBloc.getCart();
  }

  int currentPage = 0;
  int cart_count = 0;

  void changePage(id) async {
    if (!await authBloc.isAuthenticated() && id == 2)
      Navigator.pushNamed(context, "loginPage");
    else
      setState(() {
        _pageController.jumpToPage(id);
        currentPage = id;
      });
  }

  Future<bool> _onBackPressed() {
    print(currentPage);
    if (currentPage == 0) {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit this application'),
          actionsPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//          actionsOverflowButtonSpacing: double.infinity,
          buttonPadding: EdgeInsets.only(right: 20),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(width: 30),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        currentPage = 0;
      });
      _pageController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(child: leftDrawerMenu()),
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
                  changePage(0),
                },
              ),
              IconButton(
                icon: currentPage == 1
                    ? SvgPicture.asset("assets/icons/category.svg",
                        color: NPrimaryColor)
                    : SvgPicture.asset("assets/icons/Category_Out_bold.svg"),
                padding: EdgeInsets.all(15),
                onPressed: () => {changePage(1)},
              ),
              Stack(children: [
                StreamBuilder<CartResponse>(
                    stream: cartBloc.subject.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Positioned(
                          right: 4,
                          top: 2,
                          child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              snapshot.data.totalItems.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      else
                        return Container(
                          height: 14,
                        );
                    }),
                IconButton(
                  icon: currentPage == 2
                      ? SvgPicture.asset("assets/icons/Cart_03.svg",
                          color: NPrimaryColor)
                      : SvgPicture.asset("assets/icons/Cart_02.svg"),
                  padding: EdgeInsets.all(10),
                  onPressed: () => {changePage(2)},
                ),
              ]),
              IconButton(
                padding: EdgeInsets.all(10),
                icon: currentPage == 3
                    ? SvgPicture.asset("assets/icons/p.svg",
                        color: NPrimaryColor)
                    : SvgPicture.asset("assets/icons/person.svg"),
                onPressed: () => {changePage(3)},
              ),
            ],
          ),
        ),
      ),
    );
  }

  leftDrawerMenu() {
    Color blackColor = Colors.black.withOpacity(0.6);
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          StreamBuilder<PrefsData>(
              stream: authBloc.preference,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  height: 200,
                  child: DrawerHeader(
                    child: snapshot.data?.isAuthenticated == true
                        ? ListTile(
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 28,
                            ),
                            subtitle: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, "wishListPage");
                              },
                              child: Text(
                                "View Wishlist",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor),
                              ),
                            ),
                            title: Text(
                              snapshot.data?.user.fullName,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor),
                            ),
                            leading: CircleAvatar(
                                child: Image.asset(
                                    "assets/icons/person_placeholder.png")),
                          )
                        : ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "loginPage");
                            },
                            title: Text(
                              "Log In/Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFB),
                    ),
                  ),
                );
              }),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Icon(
              Icons.home,
              color: ksecondaryColor,
            ),
            title: Text(
              'Browse',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              changePage(0);
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1.0,
            color: Colors.black12,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Icon(Icons.shopping_basket, color: ksecondaryColor),
            title: Text('My orders',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () async {
              if (await authBloc.isAuthenticated() == false) {
                Navigator.pop(context);
                Navigator.pushNamed(context, "loginPage");
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, "ordersPage");
              }
            },
          ),
          Divider(
            height: 1.0,
            color: Colors.black12,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Icon(Icons.search, color: ksecondaryColor),
            title: Text('Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "searchPage");
            },
          ),
          Divider(
            height: 1.0,
            color: Colors.black12,
          ),
          ListTile(
//          leading: Container(),
            title: Container(
              margin: EdgeInsets.only(left: 50.0),
              child: Text('FAQ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor)),
            ),
            onTap: () {},
          ),
          ListTile(
//          leading: Container(),
            title: Container(
              margin: EdgeInsets.only(left: 50.0),
              child: Text('Terms of Use',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor)),
            ),
            onTap: () {},
          ),
          ListTile(
//          leading: Container(),
            title: Container(
              margin: EdgeInsets.only(left: 50.0),
              child: Text('Privacy Policy',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor)),
            ),
            onTap: () {},
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
}
