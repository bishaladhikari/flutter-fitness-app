import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'pattern_validation_container.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressPage(),
    ));

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required*";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: new Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 10.0),
              child: new Text(
                'Cancel',
                style: TextStyle(color: Colors.black, fontSize: 15),
              )),
          title: new Text(
            'Add New Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SingleChildScrollView(
                child: Form(
              // autovalidate: true,
              key: formkey,
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Name"),
                  validator: validatepass,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: "Mobile",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Contact*"),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                    ])),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email"),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: " Region",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Region"),
                  validator: validatepass,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "City",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "city"),
                  validator: validatepass,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Area",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Area"),
                  validator: validatepass,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 120, 20),
                  child: Text(
                    "Select a label for effective delivery",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Row(children: <Widget>[
                  Container(
                      margin: new EdgeInsets.symmetric(horizontal: 50.0),
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                          child: Row(children: <Widget>[
                        Container(
                          height: 30.0,
                          child: SvgPicture.asset("assets/icons/home.svg"),
                          // width: MediaQuery.of(context).size.width*0.15
                          width: 15.0,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ]))),
                  Expanded(
                    child: Container(
                        margin: new EdgeInsets.symmetric(horizontal: 50.0),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                            child: Row(children: <Widget>[
                          Container(
                            height: 30.0,
                            child: SvgPicture.asset("assets/icons/menu.svg"),
                            // width: MediaQuery.of(context).size.width*0.15
                            width: 15.0,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          Text(
                            'Office',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ]))),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 133, 0),
                  child: Text(
                    "Make a default shipping address",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 157, 20),
                  child: Text(
                    "Make a default biling address",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                GestureDetector(
                  onTap: validate,
                  child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))),
                )
              ]),
            ))));
  }
}
