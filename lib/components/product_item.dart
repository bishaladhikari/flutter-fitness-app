import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/main_bloc.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/bloc/wishlist_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final width;

  ProductItem({this.product, this.width = 162.0});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductDetailBloc productDetailBloc;

  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = widget.width;
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 295,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Color(0xFFB0CCE1).withOpacity(0.32),
                ),
              ],
            ),
            width: widget.width,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _productImage(),
                      SizedBox(height: 8),
                      _productDetails()
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(tr('Add To Cart'),
                            style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          var params = {
                            "attribute_id": widget.product.attributeId,
                            "combo_id": null,
                            "quantity": 1
                          };
                          addToCart(context, params);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        if (await mainBloc.isInternetAvailable())
          Navigator.pushNamed(context, "productDetailPage",
              arguments: widget.product);
        else
          Navigator.pushNamed(context, "noInternetPage");
      },
    );
  }

  _productImage() {
    return Hero(
      tag: widget.product.heroTag,
      child: Stack(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            imageUrl: widget.product.imageThumbnail,
            imageBuilder: (context, imageProvider) => Container(
              height: 130,
              // width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              )),
            ),
            errorWidget: (context, url, error) => Center(
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Positioned(
            top: 2.0,
            right: 2.0,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              color: !widget.product.saved ? Colors.black38 : Colors.green,
              onPressed: () {
                var params = {
                  "attribute_id": widget.product.attributeId,
                  "combo_id": null,
                };
                !widget.product.saved
                    ? addToWishList(context, params)
                    : removeFromWishList(context, params);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDetails() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.product.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: kTextColor),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                widget.product.category.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 11, color: Color(0XFFb1bdef)),
              ),
              Spacer(),
              Text(widget.product.avgRating.toString()),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orange,
              )
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text(
                  widget.product.discountPrice != null
                      ? "\¥" + widget.product.discountPrice
                      : "\¥" + widget.product.sellingPrice,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: NPrimaryColor)),
              SizedBox(width: 6),
              widget.product.discountPrice != null
                  ? Text(
                      "\¥" + widget.product.sellingPrice,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough),
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  addToCart(context, params) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      AddToCartResponse response = await cartBloc.addToCart(params);
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(tr("Item added to cart")),
          backgroundColor: NPrimaryColor,
        ));
      }
    }
  }

  addToWishList(context, params) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      AddToWishlistResponse response = await wishListBloc.addToWishList(params);
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        widget.product.saved = true;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Item added to wish list"),
          backgroundColor: NPrimaryColor,
        ));
      }
    }
  }

  removeFromWishList(context, params) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      RemoveFromWishlistResponse response =
          await wishListBloc.removeFromWishList(params);
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        widget.product.saved = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(tr(response.message)),
          backgroundColor: NPrimaryColor,
        ));
      }
    }
  }
}
