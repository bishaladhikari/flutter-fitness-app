import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/message_response.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailConfirmPage extends StatefulWidget {
  String email;

  EmailConfirmPage({Key key, this.email}) : super(key: key);

  @override
  _EmailConfirmState createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirmPage>
    with SingleTickerProviderStateMixin {
  String email;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String otpCode = "";

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        MessageResponse response = await authBloc.resendOTPCode({
          "email": "${widget.email}",
        });

        Fluttertoast.showToast(
            msg: response.error == null ? response.message : response.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: response.error == null ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
                          otpCode = value;
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
              GestureDetector(
                onTap: () => validateOTP(context),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: NPrimaryColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                      child: Text(
                    tr("VERIFY".toUpperCase()),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateOTP(BuildContext context) async {
    formKey.currentState.validate();
    if (otpCode.length != 6) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        hasError = true;
      });
    } else {
      setState(() {
        hasError = false;
      });

      MessageResponse response = await authBloc.confirmEmailOTP({
        "email": "${widget.email}",
        "otp": otpCode,
      });

      Fluttertoast.showToast(
          msg: response.error == null ? response.message : response.error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: response.error == null ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      if (response.error == null) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('loginPage');
      }
    }
  }
}
