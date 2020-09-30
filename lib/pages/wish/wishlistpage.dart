import 'package:ecapp/bloc/wishlist_bloc.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/wish.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  WishListPage() {
//    authBloc.isAuthenticated==false
//        Navigator.of(context,rootNavigator: true).push("/loginPage")
  }

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishListBloc.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<WishlistResponse>(
          stream: wishListBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildWishlistItemWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          }),
      // body: Center(
      //   child: Text("I am wish list page"),
      // ),
    );
  }

  Widget _buildWishlistItemWidget(WishlistResponse data ) {
    List<Wish> wishes = data.wishes;
    return ListView.builder(
      itemCount: wishes.length,
      itemBuilder:(context,index)=> Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTileItem(
              leading: wishes[index].imageThumbnail,
              title: 'Local Chicken',
              subtitle: 'Dashai Aayo, Chicken khayo',
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text("Rs.500"),
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('Buy'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }
  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occurred: $error"),
          ],
        ));
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
