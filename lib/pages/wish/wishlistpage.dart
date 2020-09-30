import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/wishlistbloc.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  WishListPage() {
//    authBloc.isAuthenticated==false
//        Navigator.of(context,rootNavigator: true).push("/loginPage")
  }
  @override
  Widget build(BuildContext context) {
    wishListBloc.fetchWishList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
        backgroundColor: Colors.white,
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTileItem(
              leading: "assets/icons/fb.png",
              title: 'Local Chicken',
              subtitle: 'Dashai Aayo, Chicken khayo',
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text("Rs.500"),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Buy'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Text("I am wish list page"),
      // ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.

class ListTileItem extends StatelessWidget {
  final leading;
  final title;
  final subtitle;

  ListTileItem({this.leading, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Container(
          height: 50.0,
          width: 50.0,
          child: Image.asset(leading),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title), Text(subtitle)]),
        )
      ]),
    );
  }
}
