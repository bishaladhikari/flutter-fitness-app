import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailConfirmPage extends StatefulWidget {
  @override
  _EmailConfirmState createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirmPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(tr('Confirm Your Email'),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "Please, enter Verification Code that we have sent you in your mail",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        inactiveColor: NPrimaryColor,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(
                          fontSize: 23, height: 1.6, color: Colors.black),
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " RESEND",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Color(0xFF91D3B3),
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      formKey.currentState.validate();
                      // conditions for validating
                      if (currentText.length != 6) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        setState(() {
                          hasError = false;
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Aye!!"),
                            duration: Duration(seconds: 2),
                          ));
                        });
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildVerifyFormWidget(context) {
  //   return ListView(children: [
  //     Container(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //                 "Please, enter Verification Code that we have sent you in your mail",
  //                 style: TextStyle(color: Colors.black87, fontSize: 16),
  //                 textAlign: TextAlign.center),
  //           ),
  //           SizedBox(height: 50),
  //           Form(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //                 // buildCodeNumber(context, pinOneController),
  //                 // buildCodeNumber(context, pinTwoController),
  //                 // buildCodeNumber(context, pinThreeController),
  //                 // buildCodeNumber(context, pinFourController),
  //                 // buildCodeNumber(context, pinFiveController),
  //                 // buildCodeNumber(context, pinSixController),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           // Form(
  //           //   key: _formKey,
  //           //   child: Column(
  //           //     children: [
  //           //       TextFormField(
  //           //         controller: emailController,
  //           //         style: TextStyle(color: Color(0xFF000000)),
  //           //         cursorColor: Color(0xFF9b9b9b),
  //           //         keyboardType: TextInputType.phone,
  //           //         decoration: InputDecoration(
  //           //             prefixIcon: const Icon(Icons.code),
  //           //             border: OutlineInputBorder(),
  //           //             contentPadding: new EdgeInsets.symmetric(
  //           //                 vertical: 10.0, horizontal: 10.0),
  //           //             hintStyle: TextStyle(color: Colors.grey),
  //           //             hintText: "Verification Code"),
  //           //       ),
  //           //       SizedBox(height: 10),
  //           //     ],
  //           //   ),
  //           // ),
  //           Align(
  //               child: Row(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   "Didn't receive the code?",
  //                   style: TextStyle(color: Colors.black87),
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () => (context),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     tr("RESEND"),
  //                     style: TextStyle(color: Colors.green),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           )),
  //           SizedBox(height: 20),
  //           GestureDetector(
  //             onTap: () => (context),
  //             child: Container(
  //               height: 50.0,
  //               width: MediaQuery.of(context).size.width,
  //               decoration: BoxDecoration(
  //                   color: NPrimaryColor,
  //                   borderRadius: BorderRadius.circular(5.0)),
  //               child: Center(
  //                   child: Text(
  //                 tr("VERIFY"),
  //                 style: TextStyle(fontSize: 18, color: Colors.white),
  //               )),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ]);
  // }

  Widget buildCodeNumber(context, pinController) {
    final node = FocusScope.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
      child: SizedBox(
        width: 50,
        height: 60,
        child: Container(
          // decoration: BoxDecoration(border:Border(bottom: BorderSide(color: NPrimaryColor, width: 2.0))),
          child: TextFormField(
            controller: pinController,
            decoration: InputDecoration(counterText: ""),
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            maxLength: 2,
            maxLengthEnforced: true,
            // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
        ),
      ),
    );
  }
}
