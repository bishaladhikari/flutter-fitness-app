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
            margin: const EdgeInsets.symmetric(vertical:8.0),
            height: 200,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                      title: Text('Hello world')
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
