import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/models/cart_item.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,

//      mainAxisAlignment: MainAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 60,
                  width: width / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(cartItem.imageThumbnail),
                      fit: BoxFit.fitHeight,
//                            image: Image.asset(cart[i]['image']),
                    ),
                  ),
//                        child: Image.asset(cart[i]['image']),
                ),
              ),
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(cartItem.price,
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
                  color: Colors.black87.withOpacity(0.4),
                  size: 20,
                ),
                splashRadius: 5.0,
                onPressed: () {
                  cartBloc.updateCart(cartItem, "sub");
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
}
