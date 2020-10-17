import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.01),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
//              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.black.withOpacity(.01),
              child: Row(
                children: [
                  Text(
                    'Add a New Credit/Debit Card',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.security,
//                    size: 18,
                    color: NPrimaryColor,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Container(
                      width: 80,
                      child: Text(
                        "Security Guaranteed",
                        style: TextStyle(color: NPrimaryColor, fontSize: 12),
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("We accept following credit cards:"),
                      Image.asset(
                        "assets/icons/card_type_logo.png",
                        scale: 4,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail_outline),
                              border: OutlineInputBorder(),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Card Number"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Card Number is required"),
                            EmailValidator(errorText: "Not A Valid Email"),
                          ]),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Card Name"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Card Name is Required"),
                          ]),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail_outline),
                              border: OutlineInputBorder(),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Card Number"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Card Number is required"),
                            EmailValidator(errorText: "Not A Valid Email"),
                          ]),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
//                      fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Text(
                        "Rs 4,201",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                      height:5
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Text(
                        "Rs 4,201",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: NPrimaryColor,
                            fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
