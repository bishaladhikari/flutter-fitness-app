import 'package:rakurakubazzar/bloc/cart_bloc.dart';
import 'package:rakurakubazzar/models/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CheckoutCartItemView extends StatelessWidget {
  CartItem cartItem;

  CheckoutCartItemView({this.cartItem});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

//      mainAxisAlignment: MainAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 60,
                  width: width / 4,
                  margin: const EdgeInsets.only(right:10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(cartItem.imageThumbnail),
                      fit: BoxFit.contain,
//                            image: Image.asset(cart[i]['image']),
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
                      Text(cartItem.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      cartItem.attribute?.variant!=null?
                      Row(
                        children: [
                          Text(cartItem.attribute.variantTitle,
                              style: TextStyle(
//                            fontWeight: FontWeight.bold,
                                  color: Colors.black87.withOpacity(0.6))),
                          SizedBox(width: 5.0,),
                          Text(cartItem.attribute?.variant?.name,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7))),
                        ],
                      ):
                      Container(),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
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
                cartItem.availability
                    ? Text("Qty " + cartItem.quantity.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87.withOpacity(0.6)))
                    : Text(
                        "Item Unavailable",
                        style: TextStyle(color: Colors.redAccent),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
