import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rakurakubazzar/bloc/auth_bloc.dart';
import 'package:rakurakubazzar/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _navigateToWishlist() async {
    await authBloc.isAuthenticated() == true
        ? Navigator.of(context).pushNamed('wishListPage')
        : Navigator.of(context).pushNamed('loginPage');
  }

  _navigateToOrders() async {
    await authBloc.isAuthenticated() == true
        ? Navigator.of(context).pushNamed('ordersPage')
        : Navigator.of(context).pushNamed('loginPage');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildProfileCardWidget(context),
//          StreamBuilder(
//              stream: authBloc.preference,
//              builder: (context, AsyncSnapshot snapshot) {
////                return snapshot.hasData? Text(snapshot.data.user.fullName):Container();
//                return snapshot.hasData? buildProfileCardWidget();
//                return buildProfileCardWidget(context, snapshot.data);
//              }
////              buildProfileCardWidget(context)
//              ),
          SizedBox(
            height: 15.0,
          ),
          AppBarIconText(
            iconData: Icons.shopping_basket,
            title: tr("Orders"),
            subtitle: tr("Check your order status."),
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {
              _navigateToOrders();
            },
            // onPressed: () {
            //   Navigator.of(context).pushNamed('ordersPages');
            // },
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          AppBarIconText(
            iconData: Icons.help_outline,
            title: tr("Help"),
            subtitle: tr("Help regarding your recent Purchases."),
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          AppBarIconText(
            iconData: Icons.loyalty,
            title: tr("Wishlist"),
            subtitle: tr("Your Most Loved Products."),
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {
              _navigateToWishlist();
            },
          ),

          SizedBox(
            height: 15.0,
          ),
//          AppBarIconText(
//            iconData: Icons.save,
//            title: "Scan for Coupon ",
//            tralingIcon: Icons.keyboard_arrow_right,
//            onPressed: () {},
//          ),
//          Divider(
//            height: 1.0,
//            color: Colors.grey,
//          ),
          StreamBuilder<PrefsData>(
              stream: authBloc.preference,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var referCode = snapshot.data.user?.customer?.referCode;
                  return AppBarIconText(
                    iconData: Icons.attach_money,
                    title: tr("Refer & Earn"),
                    subtitle: referCode,
//                tralingIcon: Icons.keyboard_arrow_right,
                    onPressed: () {
                      var referCode = snapshot.data.user.customer.referCode;
                      FlutterClipboard.copy(referCode).then((value) =>
                          Fluttertoast.showToast(
                              msg: tr("Copied"),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0));
                    },
                  );
                }
                return Container();
              }),
          SizedBox(
            height: 15.0,
          ),
          AppBarIconText(
            title: tr("FAQs"),
            onPressed: () {},
          ),
          AppBarIconText(
            title: tr("About Us"),
            onPressed: () {},
          ),
          AppBarIconText(
            title: tr("Terms of Use"),
            onPressed: () {},
          ),
          AppBarIconText(
            title: tr("Privacy Policy"),
            onPressed: () {
              Navigator.pushNamed(context, "privacyPage");
            },
          ),
//          DiscountCard(),
        ],
      ),
    );
  }

  Widget buildProfileCardWidget(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0xFFFFFFFF),
      child: Stack(
        children: [
          Container(height: 100, color: ksecondaryColor),
          Positioned(
            bottom: 25,
            left: 25,
            child: ProfileImage(),
          ),
          StreamBuilder<PrefsData>(
              stream: authBloc.preference,
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.data?.isAuthenticated == false
                    ? Positioned(
                        right: 25,
                        bottom: 25,
                        child: GestureDetector(
                          child: _LoginSignup(),
                          onTap: () {
//                      _bottomLoginDialog(context);
                            Navigator.of(context, rootNavigator: false)
                                .pushNamed("loginPage");
                          },
                        ))
                    : Container();
              }),
          StreamBuilder<PrefsData>(
              stream: authBloc.preference,
              builder: (context, AsyncSnapshot snapshot) {
//              if(!snapshot.hasData) return Container();
                return snapshot.data?.isAuthenticated == true
                    ? Positioned(
                        left: 160,
                        bottom: 60,
                        child: Text(
                          snapshot.data.user.fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ))
                    : Container();
              }),
        ],
      ),
    );
  }

//  _bottomLoginDialog(context) {
//    return showGeneralDialog(
//        context: context,
//        barrierDismissible: false,
//        transitionDuration: Duration(milliseconds: 100),
//        barrierColor: Colors.black.withOpacity(0.1),
//        pageBuilder: (context, animation1, animation2) {
//          return Align(alignment: Alignment(0, 0), child: LoginPage());
//        },
//        transitionBuilder: (context, animation1, animation2, child) {
//          return SlideTransition(
//              position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
//                  .animate(animation1),
//              child: child);
//        });
//  }
}

class AppBarIconText extends StatelessWidget {
  final iconData;
  final title;
  final subtitle;
  final onPressed;
  final tralingIcon;

  AppBarIconText(
      {this.iconData,
      this.title,
      this.subtitle,
      this.onPressed,
      this.tralingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : SizedBox(),
        trailing: Icon(tralingIcon),
        onTap: onPressed,
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PrefsData>(
        stream: authBloc.preference,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data?.isAuthenticated &&
              snapshot.data?.user != null)
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -7),
                      blurRadius: 33,
                      color: Color(0xFF6DAED9).withOpacity(0.11),
                    ),
                  ],
                ),
                height: 100,
                width: 100,
                // margin: const EdgeInsets.only(top:0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(snapshot.data.user.userImage),
                  ),
                ));
          return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -7),
                    blurRadius: 33,
                    color: Color(0xFF6DAED9).withOpacity(0.11),
                  ),
                ],
              ),
              height: 100,
              width: 100,
              // margin: const EdgeInsets.only(top:0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/person_placeholder.png"),
                ),
              ));
        });
  }
}

class _LoginSignup extends StatelessWidget {
  _LoginSignup();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          color: NPrimaryColor, borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Text(
          "LOG IN/ SIGN UP",
          style: TextStyle(fontSize: 11, color: Colors.white),
        )),
      ),
    );
  }
}
