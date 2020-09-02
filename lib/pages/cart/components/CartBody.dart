import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I am Cart Page!'),
            Text(count.toString(), style: TextStyle(fontSize: 30),),
            RaisedButton(onPressed: (){
                setState() {
                    count += 1;
                }
            },
              child: Text('Click To ADD'),
            )
          ],
        ),
      ),
    );
  }
}

