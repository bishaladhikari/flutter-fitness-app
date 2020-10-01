import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
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
        body: ListView(children: <Widget>[
          DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressPage()));
              },
              child: Container(
                // width: 310.0,
                height: 125.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_location),
                  color: Colors.orange,
                  onPressed: () {},
                ),
                Text(
                  'Bishal Adhikari',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              
                 FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressPage()));
              },
                padding: const EdgeInsets.fromLTRB(180, 0, 30, 0),
              child: Text(
                "Edit",
                style: TextStyle( decoration: TextDecoration.underline,color: Colors.blue, fontSize: 15),
              ),
            ),
          
              ])),
         
          
           
          Container(
            padding: const EdgeInsets.fromLTRB(55, 0, 30, 0),
            child: Text(
              '9812345678',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          Row(
           
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(55, 0, 30, 0),
                child: Row(children: <Widget>[
                  Text(
                    'Bagmati,Kathmandu,New Baneshwor',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                ]),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: Row(children: <Widget>[
                  Text(
                    'Area, Buddhanagar',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                ]),
              )
            ],
          ),
        ]));
  }
}
