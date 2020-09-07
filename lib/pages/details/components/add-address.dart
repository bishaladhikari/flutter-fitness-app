import 'package:flutter/material.dart';
// import 'package:ecapp/pages/details/components/add-address.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressPage(),
    ));

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Text(
            'Cancel',
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          title: new Text(
            'Add New Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                      decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  TextField(
                      decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  TextField(
                      decoration: InputDecoration(
                    hintText: "Region",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  TextField(
                      decoration: InputDecoration(
                    hintText: "City",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  TextField(
                      decoration: InputDecoration(
                    hintText: "Area",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  TextField(
                      decoration: InputDecoration(
                    hintText: "Address",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Select a label for effective delivery",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                         margin: new EdgeInsets.symmetric(horizontal: 50.0),
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                             border: Border.all(color: Colors.blue,
                         width: 1.0,),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                              child: Row(children: <Widget>[
                            FlutterLogo(),
                            Text(
                              'Home',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ]))),
                      Expanded( child: Container(
                        margin: new EdgeInsets.symmetric(horizontal: 50.0),
                        width: 100,
               height:50,
               decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,
                         width: 1.0,),
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.white
               ),
               child: Center(
                              child: Row(children: <Widget>[
                            FlutterLogo(),
                            Text(
                              'Office',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ]))),
             ),]
                      
                      
                    
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Make a default shipping address",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Make a default biling address",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange[900]),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )))
                ])));
  }
}
