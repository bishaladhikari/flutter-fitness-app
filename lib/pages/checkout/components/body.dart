import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';

class CheckoutPageBody extends StatefulWidget {
  @override
  _CheckoutPageBodyState createState() => _CheckoutPageBodyState();
}

class _CheckoutPageBodyState extends State<CheckoutPageBody> {
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black.withOpacity(.01),
            child: Text(
              'Recommended method(s)',
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color:Colors.white,
            padding: EdgeInsets.symmetric( vertical: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

//            mainAxisAlignment:,
              children: [
                Expanded(
                  child: Icon(
                    Icons.credit_card,
                    size: 50,
                  ),
                ),
                Wrap(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Text(
                              "Credit/Debit Card",
                              style: TextStyle(fontSize: 20, color:Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.home),
                            Icon(Icons.home),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Text('Credit/Debit Card'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:Text('Get partner discount upto 20%', style: TextStyle(color:Colors.white ),)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(

//                cro,
                  child: Container(
                    alignment: Alignment.centerRight,

                    child: IconButton(

                      icon: Icon(Icons.arrow_back_ios)
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black.withOpacity(.01),
            child: Text(
              'Payment methods',
              style:
              TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color:Colors.white,

            height: 50,
//          padding: EdgeInsets.symmetric( vertical: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

//            mainAxisAlignment:,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Image(
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSKPmUEm6MjUd2w0ZhQTZYp2BQEflPpIRGC_w&usqp=CAU'),
                  ),
                ),
                Wrap(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cash On Delivery",
                          style: TextStyle(fontSize: 20, color:Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,

                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios)
                      ),
                    )
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}