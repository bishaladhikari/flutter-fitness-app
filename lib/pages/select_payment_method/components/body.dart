import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class SelectPaymentBody extends StatefulWidget {
  @override
  _SelectPaymentBodyState createState() => _SelectPaymentBodyState();
}

class _SelectPaymentBodyState extends State<SelectPaymentBody> {
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
            onTap: (){
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
                    child: Image.asset("assets/icons/creditdebit.png",scale:2,),
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
                              Image.asset("assets/icons/card_type_logo.png",scale: 6,),
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
                        iconSize: 18, icon: Icon(Icons.arrow_forward_ios)),
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
            onTap: (){
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
                      child: Image.asset("assets/icons/cash_on_delivery.png",scale:2),
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
                                  color: Colors.black,),
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