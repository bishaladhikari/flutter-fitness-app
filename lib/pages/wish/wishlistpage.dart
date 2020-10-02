import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecapp/bloc/wishlist_bloc.dart';
import 'package:ecapp/models/image.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/wish.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

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
              return _buildWishlistWidget(snapshot.data);
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

  Widget _buildWishlistWidget(WishlistResponse data ) {
    List<Wish> wishes = data.wishes;
    return ListView.builder(
      itemCount: wishes.length,
      itemBuilder:(context,index)=> WishlistItemView(item:wishes[index]),
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
          child: CachedNetworkImage(imageUrl:leading),
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
class WishlistItemView extends StatelessWidget{
  final item;
  WishlistItemView({this.item});
  @override
  Widget build(BuildContext context) {
    print("Item:"+item.toJson().toString());
       return Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 1),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height:83.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(
                              item.image
                            ),
                            fit: BoxFit.fitHeight,
//                            image: Image.asset(cart[i]['image']),
                          ),
                        ),
//                        child: Image.asset(cart[i]['image']),
                      ),
                    ),
                    Expanded(
                      child: Container(
//                        padding:
//                            EdgeInsets.symmetric(horizontal: 10, vertical: 23),
//                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.productName,
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(height: 10),
                            Text(item.sellingPrice, style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Padding(padding:EdgeInsets.only(right:20.0),child: IconButton(icon:Icon(Icons.delete),color:Colors.black26,onPressed: (){
                      wishListBloc.deleteWishList(item.id);
                    },))
                    ],
                ),
              );
           
  }


  
}