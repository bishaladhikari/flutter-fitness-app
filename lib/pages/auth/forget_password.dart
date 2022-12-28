import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/auth_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/response/email_confirm_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgetPasswordPage extends StatefulWidget {
  String email;

  ForgetPasswordPage({Key key, this.email}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordPage>
    with SingleTickerProviderStateMixin {
  String email;
  bool _validate = false;
  bool _passwordObscureText = true;
  bool _conformObscureText = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    reTypePasswordController.dispose();
  }

  void _toggle() {
    setState(() {
      _passwordObscureText = !_passwordObscureText;
    });
  }

  void _resetToggle() {
    setState(() {
      _conformObscureText = !_conformObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(tr('Change Password'),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: _buildChangePasswordFormWidget());
  }

  Widget _buildChangePasswordFormWidget() {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  tr(
                      "Reset your password with the help of code sent to your mail"),
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,

              child: Column(
                children: [
                  TextFormField(
                    controller: codeController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.code),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Code"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Code is required"),
                    ]),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: newPasswordController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordObscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: _toggle,
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "New Password"),
                    obscureText: _passwordObscureText,
                    validator: MultiValidator([
                      PatternValidator(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          errorText:
                          'The Password must include a Lower case, a Upper Case, a digit, a symbol and more than 8 character')
                    ]),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: reTypePasswordController,
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Color(0xFF9b9b9b),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_conformObscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: _resetToggle,
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Retype Password"),
                      obscureText: _conformObscureText,
                      validator: (val) {
                        if (val.isEmpty) return 'Empty';
                        if (val != newPasswordController.text)
                          return 'Not Match';
                        return null;
                      }),
                  SizedBox(height: 20),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => validateUpdatePassword(context),
              child: Container(
                height: 50.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  validateUpdatePassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      EmailConfirmResponse response = await authBloc.forgotPasswordUpdate({
        "email": "${widget.email}",
        "opt": "${codeController.text}",
        "password": "${newPasswordController.text}"
      });

      Fluttertoast.showToast(
          msg: response.error == null ? response.message : response.error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: response.error == null ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      if (response.error == null) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('loginPage');
      }
    } else {
      setState(() => _validate = true);
    }
  }
}
