import 'package:ecapp/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../constants.dart';
import '../details/components/../../address-book/address-form-page.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    addressBloc.getAddress();
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            ' My Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DottedBorder(
              // padding: EdgeInsets.all(20.0),
              color: Colors.black,
              strokeWidth: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
          ),
          StreamBuilder(
              stream: addressBloc.address,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.addresses.isNotEmpty)
                  return ListView.builder(
                    itemCount: snapshot.data.addresses.length,
                    shrinkWrap: true,
                    itemBuilder: (_,index){
                    final item = snapshot.data.addresses[index];
                   return Container(
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
                              item.name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            Spacer(),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                          ]));
                  });
                          return Container();
              }),
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
