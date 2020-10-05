import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../constants.dart';
import '../details/components/../../address-book/add-address.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationPage(),
    ));

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            ' My Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: 
        ListView(children: <Widget>[
          DottedBorder(
            // padding: EdgeInsets.all(20.0),
            color: Colors.black,
            strokeWidth: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressPage()));
              },
              child: Container(
                // width: 310.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: const Color(0XFFB3E5FC),
                  // border:
                  //     Border.all(color: Colors.blue, style: BorderStyle.solid),
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  " + Add address",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                ),
                alignment: Alignment(
                  0.0,
                  0.0,
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.add_location,
                      color: Colors.orange,
                    ),
                    Text(
                      'Bishal Adhikari',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressPage()));
                      },
                      // padding: const EdgeInsets.fromLTRB(180, 0, 30, 0),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 15),
                      ),
                    ),
                  ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('9806050253',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                  Text('Bagmati,Kathmandu,New Baneshwor',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                  Text('Area, Buddhanagar',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                ]),
          ),
        ]));
  }
}
