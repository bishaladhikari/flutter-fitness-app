import 'package:ecapp/bloc/address_bloc.dart';
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
                  if (snapshot.hasData && snapshot.data.addresses.isNotEmpty)
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
                                      horizontal: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_location,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          item.name.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                        Spacer(),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, 'addressFormPage');
                                          },
                                          // padding: const EdgeInsets.fromLTRB(180, 0, 30, 0),
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ])),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(item.phone.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(item.house.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(item.city.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              ),
                            ],
                          );
                        });
                  return Container();
                }),
          ]),
        ));
  }
}
