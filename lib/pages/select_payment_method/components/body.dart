import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';

class SelectPaymentBody extends StatefulWidget {
  @override
  _SelectPaymentBodyState createState() => _SelectPaymentBodyState();
}

class _SelectPaymentBodyState extends State<SelectPaymentBody> {
  int rewardPoints = 10;
  bool triggerCheckbox = false;

  @override
  void initState() {
//    StripePayment.setOptions(
//        StripeOptions(publishableKey: "pk_test_aSaULNS8cJU6Tvo20VAXy6rp", merchantId: "Test", androidPayMode: 'test'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.01),
      child: Column(
//      color,

//      bac,
        children: [
          rewardPoints > 0
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'You currently have ',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            rewardPoints.toString(),
                            style: TextStyle(
                                color: NPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' Reward Points to spend.',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'You can use your reward points and card payment/ cash on deliery options simultaneously.',
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          triggerCheckbox
                              ? IconButton(
                                  color: NPrimaryColor,
                                  onPressed: () {
                                    print('clicked');

                                    setState(() {
                                      triggerCheckbox = false;
                                    });
                                  },
                                  icon: Icon(Icons.radio_button_checked),
                                )
                              : IconButton(
                                  color: NPrimaryColor,
                                  onPressed: () {
                                    setState(() {
                                      triggerCheckbox = true;
                                    });
                                  },
                                  icon: Icon(Icons.radio_button_unchecked),
                                ),
                        ],
                      ),
                      triggerCheckbox
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
//                                width: double.infinity/2,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black54)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Amount'),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                RaisedButton(
                                  color : NPrimaryColor,
                                  textColor: Colors.white,
                                  elevation: .2,

//                                  ,
                                  onPressed: () {
                                    Fluttertoast.showToast(
//                                        i,
                                        msg: "Redeem Successful",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: NPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0
                                    );
                                  },
                                  child: Text('Redeem'),

                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  color: NPrimaryColor.withOpacity(.2),
                                  child: Text(
                                    'Note: 1 reward point is equal to ¥1',
                                    style:
                                    TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  child: Text(
                    'Sorry! You have no reward points',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.black.withOpacity(.01),
            child: Text(
              'Recommended method(s)',
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "cardPaymentPage");
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

//            mainAxisAlignment:,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset(
                      "assets/icons/creditdebit.png",
                      scale: 2,
                    ),
                  ),
                  Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Credit/Debit Card",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/icons/card_type_logo.png",
                                scale: 6,
                              ),
//                            Icon(Icons.home),
                            ],
                          ),
                          Text('Credit/Debit Card'),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      iconSize: 18,
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                  ))
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.black.withOpacity(.01),
            child: Text(
              'Payment methods',
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "cashOnDeliveryPage");
            },
            child: Container(
              color: Colors.white,

              height: 50,
//          padding: EdgeInsets.symmetric( vertical: 10),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

//            mainAxisAlignment:,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset("assets/icons/cash_on_delivery.png",
                          scale: 2),
                    ),
                    Wrap(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        iconSize: 18,
                        onPressed: () {},
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
