import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.01),
      child: Column(
//      color,

//      bac,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

//            mainAxisAlignment:,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset("assets/icons/cash_on_delivery.png",scale:2,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text(
                            "You can pay in cash to our courier when you receive the goods at your doorstep.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
//                                    fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
