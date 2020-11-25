import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/profile_bloc.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constants.dart';

class AccountInformationPage extends StatefulWidget {
  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool _validate = false;

  AuthBloc authBloc;

  @override
  void dispose() {
    super.dispose();
    authBloc = AuthBloc();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            'Account Information',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: nameUpdateFormWidget(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              StreamBuilder<PrefsData>(
                                  stream: authBloc.preference,
                                  builder: (context, snapshot) {
                                    return snapshot.data?.isAuthenticated ==
                                            true
                                        ? Positioned(
                                            left: 160,
                                            bottom: 60,
                                            child: Text(
                                              snapshot.data.user.fullName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ))
                                        : Container();
                                  }),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  iconSize: 18,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: mobileNumberUpdateFormWidget(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  child: Text(
                                tr("Bishal Adhakari"),
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              )),
                              Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  iconSize: 18,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "cashOnDeliveryPage");
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              iconSize: 18,
                              onPressed: () {},
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget nameUpdateFormWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidate: _validate,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Name",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.cancel, color: Colors.orange, size: 25),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: firstNameController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "First Name"),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "You cannot leave this field empty"),
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: lastNameController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Last Name"),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Last Name is required"),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => validateNameUpdate(context),
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateNameUpdate(context) async {
    if (_formKey.currentState.validate()) {
      ProfileResponse response = await profileBloc.userProfileUpdate({
        "email": "",
        "first_name": "${firstNameController.text.trim()}",
        "last_name": "${lastNameController.text.trim()}",
      });
      print([response, 'success']);
    } else {
      setState(() => _validate = true);
    }
  }

  Widget mobileNumberUpdateFormWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidate: _validate,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Mobile Number",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.cancel, color: Colors.orange, size: 25),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: firstNameController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Mobile Number"),
                validator: MultiValidator([
                  RequiredValidator(errorText: "First Name is required"),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {},
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateMobileNumberUpdate(context) async {
    if (_formKey.currentState.validate()) {
    } else {
      setState(() => _validate = true);
    }
  }
}

// Padding(
// padding: const EdgeInsets.all(10.0),
// child: SingleChildScrollView(
// child: Form(
// autovalidate: true,
// key: formkey,
// child: Column(children: <Widget>[
// TextFormField(
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: " Full Name",
// hintStyle: TextStyle(color: Colors.grey),
// labelText: "Full name"),
// validator: validatepass,
// ),
// SizedBox(
// height: 10,
// ),
// TextFormField(
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: " Last Name",
// hintStyle: TextStyle(color: Colors.grey),
// labelText: "Last name"),
// validator: validatepass,
// ),
// SizedBox(height: 10),
// TextFormField(
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: "Mobile",
// hintStyle: TextStyle(color: Colors.grey),
// labelText: "Contact"),
// validator: MultiValidator([
// PatternValidator(
// r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
// errorText: 'Not A Valid  Mobile Number')
// ])),
// SizedBox(
// height: 10,
// ),
// TextFormField(
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: "Email Address",
// hintStyle: TextStyle(color: Colors.grey),
// labelText: "Email"),
// validator: MultiValidator([
// RequiredValidator(errorText: "Required*"),
// EmailValidator(errorText: "Not A Valid Email"),
// ]),
// ),
// Padding(
// padding: EdgeInsets.only(top: 30.0),
// ),
// GestureDetector(
// onTap: validate,
// child: Container(
// height: 45,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: NPrimaryColor),
// child: Center(
// child: Text(
// 'Update',
// style: TextStyle(color: Colors.white, fontSize: 18),
// ))),
// )
// ]),
// ))));
