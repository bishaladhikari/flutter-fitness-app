import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            decoration: new BoxDecoration(
              color: Colors.deepOrangeAccent,

            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text('Hello world')
                    ],
                  ),
                )
              ],
            ),

          )
//          DiscountCard(),
        ],
      ),
    );
  }
}
