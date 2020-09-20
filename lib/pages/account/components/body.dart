import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            color: Color(0xFFFFFFFF),
            child: Stack(
              children: [
                Container(height: 100, color: Color(0xFF525462)),
                Positioned(
                  bottom: 25,
                  left: 25,
                  child: ProfileImage(),
                ),
                Positioned(right: 25, bottom: 25, child: LoginSignup())
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          AppBarIconText(
            iconData: Icons.shopping_basket,
            title: "Orders",
            subtitle: "Check your order status.",
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          AppBarIconText(
            iconData: Icons.help_outline,
            title: "Help ",
            subtitle: "Help regarding your recent Purchases.",
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          AppBarIconText(
            iconData: Icons.loyalty,
            title: "Wishlist ",
            subtitle: "Your Most Loved Styles.",
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
          
          SizedBox(
            height: 15.0,
          ),
          AppBarIconText(
            iconData: Icons.save,
            title: "Scan for Coupon ",
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
           Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          AppBarIconText(
            iconData: Icons.attach_money,
            title: "Refer & Earn ",
            tralingIcon: Icons.keyboard_arrow_right,
            onPressed: () {},
          ),
          SizedBox(
            height: 15.0,
          ),
          AppBarIconText(
            title: "FAQs ",
            onPressed: () {},
          ),
          AppBarIconText(
            title: "About Us ",
            onPressed: () {},
          ),
          AppBarIconText(
            title: "Terms of Use ",
            onPressed: () {},
          ),
          AppBarIconText(
            title: "Privacy Policy ",
            onPressed: () {},
          ),
//          DiscountCard(),
        ],
      ),
    );
  }
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
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0)),
      child: Icon(
        Icons.person_outline,
        size: 50.0,
      ),
    );
  }
}

class LoginSignup extends StatelessWidget {
  final onPressed;
  LoginSignup({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: Color(0xFFFE3C6A), borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text("LOG IN/ SIGN UP")),
        ),
      ),
    );
  }
}
