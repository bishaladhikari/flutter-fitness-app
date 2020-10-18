import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../constants.dart';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InformationPage(),
    ));

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
 
  
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
          brightness: Brightness.dark,
          // * leading: new Padding(
          // padding: const EdgeInsets.only(top: 16.0, left: 10.0),
          // child: new Text(
          // 'Cancel',
          // style: TextStyle(color: Colors.black, fontSize: 15),
          // )),*
          title: new Text(
            'My Information',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Padding(
            padding:
                const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                child: Form(
              autovalidate: true,
              key: formkey,
              child: Column(children: <Widget>[
                  TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                    ),
                      hintText: " Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                       labelText: "Full name"
                     ),
                  validator: validatepass,
                ), 
                 SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                     border: OutlineInputBorder(
                      
                    ),
                      hintText: " Last Name",
                      hintStyle: TextStyle(color: Colors.grey),
                       labelText: "Last name"
                      ),
                  validator: validatepass,
                ),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                       border: OutlineInputBorder(
                      
                    ),
                        hintText: "Mobile",
                        hintStyle: TextStyle( color: Colors.grey),
                         labelText: "Contact"
                        ),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                ])),
SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                     border: OutlineInputBorder(
                      
                    ),
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                       labelText: "Email"
                     ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                ),
               

                 Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                GestureDetector(
                  onTap: validate,
                  child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                      color: NPrimaryColor),
                      child: Center(
                          child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))),
                )

            
               
              ]),
            )
            )
            )
            );
  }
}