import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailForgotPasswordPage extends StatefulWidget {
  @override
  _EmailForgotPasswordPageState createState() =>
      _EmailForgotPasswordPageState();
}

class _EmailForgotPasswordPageState extends State<EmailForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: _buildEmailForgotPasswordFormWidget());
  }

  _buildEmailForgotPasswordFormWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.vpn_key,
                  size: 50,
                )),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tr("Forgot your Password?"),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  tr("Don't worry! Just fill in your email and we'll help you reset your password."),
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: NPrimaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: NPrimaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: NPrimaryColor)),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: tr("Email Address")),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Email is required"),
                      EmailValidator(errorText: "Not A Valid Email"),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0),
            GestureDetector(
              onTap: () => validateEmail(context),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                  tr("RESET PASSWORD"),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateEmail(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var response = await authBloc
          .emailForgotPassword({"email": "${emailController.text}"});
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Email sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pushReplacementNamed(
            'forgetPasswordPage',
            arguments: emailController.text);
      }
    } else {
      setState(() => _validate = true);
    }
  }
}
