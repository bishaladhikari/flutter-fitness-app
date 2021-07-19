import 'package:rakurakubazzar/bloc/profile_bloc.dart';
import 'package:rakurakubazzar/models/response/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:rakurakubazzar/models/profile.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants.dart';

class ProfileFormWidget extends StatefulWidget {
  final Profile profile;

  ProfileFormWidget({this.profile});

  @override
  _ProfileFormWidgetState createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget>
    with AutomaticKeepAliveClientMixin {
  static final _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _validate = false;
  Profile profile;
  @override
  void initState() {
    profile = widget.profile;
    firstNameController.text = profile.firstName;
    lastNameController.text = profile.lastName;
    mobileController.text = profile.mobile;
    emailController.text = profile.email;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildFormWidget();
  }


  _buildFormWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidate: _validate,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: firstNameController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                // textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  fillColor: NPrimaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: NPrimaryColor),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey),
                  ),
                  labelText: tr("First Name"),
                  labelStyle: TextStyle(
                      color: Colors.grey),
                  // hintText: tr("First Name"),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "You cannot leave this field empty"),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: lastNameController,
                style: TextStyle(color: Color(0xFF000000)),
                // cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  fillColor: NPrimaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: NPrimaryColor),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey),
                  ),
                  labelText: tr("Last Name"),
                  labelStyle: TextStyle(
                      color: Colors.grey),
                  // hintText: tr("Last Name"),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "You cannot leave this field empty"),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                readOnly: true,
                style: TextStyle(color: Color(0xFF000000)),
                // textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  fillColor: NPrimaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: NPrimaryColor),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey),
                  ),
                  labelText: tr("Email"),
                  labelStyle: TextStyle(
                      color: Colors.grey),
                  // hintText: tr("Mobile Number"),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: mobileController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                // textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  fillColor: NPrimaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: NPrimaryColor),
                  ),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey),
                  ),
                  labelText: tr("Mobile Number"),
                  labelStyle: TextStyle(
                      color: Colors.grey),
                  // hintText: tr("Mobile Number"),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "You cannot leave this field empty"),
                ]),
              ),
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
                        "Save",
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
        "email": "",
        "first_name": "${firstNameController.text}",
        "last_name": "${lastNameController.text}",
        "mobile": "${mobileController.text}",
      };

      ProfileResponse response = await profileBloc.userProfileUpdate(params);

      if (response.error == null) {
        Fluttertoast.showToast(
            msg: "Success",
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
  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
  }
  @override
  bool get wantKeepAlive => true;
}
