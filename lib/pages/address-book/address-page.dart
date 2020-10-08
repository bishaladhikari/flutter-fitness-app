import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddressPage extends StatelessWidget {
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
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DottedBorder(
                // padding: EdgeInsets.all(20.0),
                color: Colors.black,
                strokeWidth: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'addressFormPage');
                  },
                  child: Container(
                    // width: 310.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: const Color(0XFFB3E5FC),
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
                stream: addressBloc.addresses,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.addresses.isNotEmpty){
                    List<Address> addresses  = snapshot.data.addresses;
                    return ListView.builder(
                        itemCount: snapshot.data.addresses.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final item = snapshot.data.addresses[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,vertical: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                                          child: Icon(
                                            Icons.add_location,
                                            color: Colors.orange,
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name.toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16),
                                            ),
                                            Text(item.phone.toString(),
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 14)),
                                            Text(item.house.toString(),
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 14)),
                                            Text(item.city.toString(),
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Spacer(),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, 'addressFormPage',
                                              arguments: addresses[index]);
                                          },
                                          // padding: const EdgeInsets.fromLTRB(180, 0, 30, 0),
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
//                                                decoration:
//                                                TextDecoration.underline,
                                                color: Colors.black38,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ])),
                            ],
                          );
                        });

                  }
                  return Container();
                }),
          ]),
        ));
  }
}
