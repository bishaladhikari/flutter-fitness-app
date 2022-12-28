import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/profile_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/response/email_confirm_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  static final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _validate = false;

  bool _currentPassword = true;
  bool _newPassword = true;
  bool _confirmPassword = true;

  void _currentPasswordToggle() {
    setState(() {
      _currentPassword = !_currentPassword;
    });
  }

  void _newPasswordToggle() {
    setState(() {
      _newPassword = !_newPassword;
    });
  }

  void _confirmPasswordToggle() {
    setState(() {
      _confirmPassword = !_confirmPassword;
    });
  }

  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.close),
          ),
          title: Text(tr("Change Password"),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child: _buildFormWidget()));
  }

  Widget _buildFormWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(

          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: currentPasswordController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                // textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_confirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _currentPasswordToggle,
                    ),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Current Password"),
                obscureText: _confirmPassword,
                validator: MultiValidator([
                  RequiredValidator(errorText: "You cannot leave this empty"),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: newPasswordController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.visiblePassword,
                // textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_newPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _newPasswordToggle,
                    ),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "New Password"),
                obscureText: _newPassword,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "You cannot leave this empty";
                  } else if (value.length < 8) {
                    return "Password must be greater than 8 characters";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: confirmPasswordController,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_confirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _confirmPasswordToggle,
                      ),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Confirm Password"),
                  obscureText: _confirmPassword,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "You Cannot leave this empty";
                    } else if (value.length < 8) {
                      return "Password must be greater than 8 characters";
                    } else if (value != newPasswordController.text) {
                      return "Password do not match.";
                    }
                    return null;
                  }),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => validateUserProfile(context),
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: NPrimaryColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                      child: Text(
                    "Update",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateUserProfile(context) async {
    if (_formKey.currentState.validate()) {
      var params = {
        "current_password": "${currentPasswordController.text}",
        "new_password": "${newPasswordController.text}",
        "confirm_password": "${confirmPasswordController.text}",
      };

      EmailConfirmResponse response =
          await profileBloc.userPasswordUpdate(params);

      if (response.error == null) {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: response.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      setState(() => _validate = true);
    }
  }
}
