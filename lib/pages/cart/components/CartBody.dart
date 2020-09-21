import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List cart = [
    {'name': 'Cabbage', 'price': 'Rs 100', 'image': 'assets/images/burger_single.png', 'count':1},
    {'name': 'Tomato', 'price': 'Rs 50', 'image': 'assets/images/tomato.png', 'count': 5},
    {'name': 'Potato', 'price': 'Rs 250', 'image': 'assets/images/tomato.png', 'count':2},
  ];
  @override
  subCount(i){
    setState((){
      cart[i]['count']--;
    });
  }
  incCount(i){
    setState((){
      cart[i]['count']++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(cart.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF4F5F5),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: cart.length,
            itemBuilder: (context, i) {
              return Container(
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
                            image: AssetImage(cart[i]['image']),
                            fit: BoxFit.cover,
//                            image: Image.asset(cart[i]['image']),
                          ),
                        ),
//                        child: Image.asset(cart[i]['image']),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 23),
                        color: Colors.white,
//                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cart[i]['name'],
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text(cart[i]['price'], style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 26.5),
//                          height: 50,
                          color: Colors.white,
                          width: 200,
                          child: Stack(
                            children: [
                              Container(
//                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: kForeGroundColor)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Center(
                                  child: Text(cart[i]['count'].toString(), style: TextStyle(color: Colors.black),),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  subCount(i);
                                },
                                child: Container(
//                                width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: kForeGroundColor)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    '-',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  incCount(i);
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: kForeGroundColor)),
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
                          )),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
