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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            height: 83.5,
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
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Text("Rs 250",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
//                        subCount(i);
                        },
                        child: Container(
//                                width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:
                              Border.all(color: kForeGroundColor)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
//                                height: 50,
//                      width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: kForeGroundColor)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Center(
                          child: Text(
                            cartItem.quantity.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
//                        incCount(i);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                Border.all(color: kForeGroundColor)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              '+',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ],
            ),
          ),
        )
      ],
    );
  }
}
