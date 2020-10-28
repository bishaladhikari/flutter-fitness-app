import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/models/cart_item.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CartItemView extends StatelessWidget {
  CartItem cartItem;

  CartItemView({this.cartItem});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Hero(
                  tag: cartItem.heroTag,
                  child: Container(
                    height: 60,
                    width: width / 4,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(cartItem.imageThumbnail),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartItem.attribute != null
                              ? _navigateToProductDetail(context)
                              : _navigateToComboDetail(context);
                        },
                        child: Text(cartItem.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      cartItem.attribute?.variant != null
                          ? Row(
                              children: [
                                Text(cartItem.attribute.variantTitle,
                                    style: TextStyle(
//                            fontWeight: FontWeight.bold,
                                        color:
                                            Colors.black87.withOpacity(0.6))),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(cartItem.attribute?.variant?.name,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7))),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("\¥ " + cartItem.price,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: NPrimaryColor)),
                          ]),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black87.withOpacity(0.3),
                  size: 20,
                ),
                splashRadius: 5.0,
                onPressed: () {
                  cartBloc.deleteFromCartList(cartItem.id);
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.black87.withOpacity(0.5),
                  size: 20,
                ),
                splashRadius: 5.0,
                onPressed: () {
                  if (cartItem.quantity > 1)
                    cartBloc.updateCart(cartItem, "sub");
                },
              ),
              Container(
//                                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kForeGroundColor)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Center(
                  child: Text(
                    cartItem.quantity.toString(),
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
                  cartBloc.updateCart(cartItem, "add");
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _navigateToProductDetail(BuildContext context) {
    Product product = Product();
    product.name = cartItem.attribute.productName;
    product.slug = cartItem.attribute.slug;
    product.imageThumbnail = cartItem.attribute.imageThumbnail;
    product.heroTag = cartItem.heroTag;
    product.avgRating = 0;

    Navigator.pushNamed(context, "productDetailPage", arguments: product);
  }

  _navigateToComboDetail(BuildContext context) {
    Combo combo = Combo();
    combo.title = cartItem.combo.title;
    combo.slug = cartItem.combo.slug;
    combo.imageThumbnail = cartItem.combo.imageThumbnail;
    combo.heroTag = cartItem.heroTag;
    Navigator.pushNamed(context, "comboDetailPage", arguments: combo);
  }
}
