import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/auth_bloc.dart';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/bloc/main_bloc.dart';
import 'package:fitnessive/bloc/product_detail_bloc.dart';
import 'package:fitnessive/bloc/wishlist_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/cart.dart';
import 'package:fitnessive/models/cart_item.dart';
import 'package:fitnessive/models/product.dart';
import 'package:fitnessive/models/response/add_to_cart_response.dart';
import 'package:fitnessive/models/response/add_to_wishlist.dart';
import 'package:fitnessive/models/response/cart_response.dart';
import 'package:fitnessive/models/response/remove_from_wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_error_widget.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final width;

  ProductItem({this.product, this.width = 162.0});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductDetailBloc productDetailBloc;
  bool saved;
  bool loading;
  CartItem cartItem;

  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    saved = widget.product.saved ?? false;
    loading = false;
//    cartItem = CartItem(quantity: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = widget.width;
    return GestureDetector(
        onTap: () async {
          if (await mainBloc.isInternetAvailable())
            Navigator.pushNamed(context, "productDetailPage",
                arguments: widget.product);
          else
            Navigator.pushNamed(context, "noInternetPage");
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 275,
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
                        SizedBox(height: 5),
                        _productDetails(),
                        Divider(),
                      ],
                    ),
                    // Positioned(
                    //   top: 2.0,
                    //   right: 2.0,
                    //   child: Container(
                    //     height: 40.0,
                    //     width: 40.0,
                    //     decoration: BoxDecoration(
                    //       color: saved ? NPrimaryColor : Colors.white,
                    //       borderRadius: BorderRadius.circular(30),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 3,
                    //           blurRadius: 7,
                    //           offset: Offset(0, 2),
                    //         ),
                    //       ],
                    //     ),
                    //     child: IconButton(
                    //       icon: Icon(Icons.favorite_border),
                    //       color: !saved ? Colors.black38 : Colors.white,
                    //       onPressed: () {
                    //         var params = {
                    //           "attribute_id": widget.product.attributeId,
                    //           "combo_id": null,
                    //         };
                    //         !saved
                    //             ? addToWishList(context, params)
                    //             : removeFromWishList(context, params);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        child: FlatButton(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(tr('Add To Cart'),
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
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
                    loading ? LinearProgressIndicator() : Container()
                  ],
                ),
              ),
            )
          ],
        ));
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _addToCartWidget(context, CartResponse data) {
//    if (cartItem != null) cartItem = CartItem(quantity: 0);
    List<Cart> carts = data.carts;
//    if (cartItem == null)
    for (int i = 0; i < carts?.length ?? 0; i++) {
      List<CartItem> cartItems = carts[i].items;
      for (int i = 0; i < cartItems?.length ?? 0; i++) {
        if (widget.product.attributeId == cartItems[i].attribute.id)
          cartItem = cartItems[i];
        else
          cartItem = CartItem(quantity: 0);
      }
    }
    return Center(
      child: Column(
        children: [
          Text(
            tr("Add to cart"),
            style: TextStyle(fontSize: 12),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.black87.withOpacity(0.5),
                  size: 20,
                ),
                splashRadius: 5.0,
                onPressed: () async {
                  if (cartItem.quantity > 1)
                    cartBloc.updateCart(cartItem, "sub");
                  else if (cartItem.quantity == 1) {
                    CartResponse response =
                        await cartBloc.deleteFromCartList(cartItem.id);
                    if (response.error == null)
                      setState(() {
                        cartItem = CartItem(quantity: 0);
                      });
                  }
                },
              ),
              Container(
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kForeGroundColor)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Text(
                    cartItem?.quantity?.toString() ?? "0",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black87.withOpacity(0.5),
                  size: 20,
                ),
                splashRadius: 5.0,
                onPressed: () {
                  var params = {
                    "attribute_id": widget.product.attributeId,
                    "quantity": 1,
                    "combo_id": null,
                  };
                  cartItem?.quantity > 0
                      ? cartBloc.updateCart(cartItem, "add")
                      : addToCart(context, params);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _productImage() {
    return Hero(
      tag: widget.product.heroTag,
      child: CachedNetworkImage(
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
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: kTextColor),
          ),
          SizedBox(
            height: 5,
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
              widget.product.avgRating.toString() == '0.0'
                  ? Container()
                  : Row(
                      children: [
                        Text(widget.product.avgRating.toStringAsFixed(0)),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orange,
                        )
                      ],
                    ),
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
          SizedBox(height: 2),
        ],
      ),
    );
  }

  addToCart(context, params) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      setState(() {
        loading = true;
      });
      AddToCartResponse response = await cartBloc.addToCart(params);
      Scaffold.of(context).removeCurrentSnackBar();

      setState(() {
        loading = false;
      });
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
//        setState(() {
//          cartItem = response.cartItem;
//        });
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
      Scaffold.of(context).removeCurrentSnackBar();
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        setState(() {
          saved = true;
        });
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
      Scaffold.of(context).removeCurrentSnackBar();
      if (response.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        setState(() {
          saved = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(tr(response.message)),
          backgroundColor: NPrimaryColor,
        ));
      }
    }
  }
}
