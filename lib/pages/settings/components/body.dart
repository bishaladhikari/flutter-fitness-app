import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/profile_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:ecapp/pages/review/review-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _validate = false;
  String email;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
              title: Text('Account Information'),
              onTap: () {
                profileBloc.userProfile();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: profileUpdateForm(),
                    ),
                  ),
                );
                // Navigator.pushNamed(context, 'accountInformation', arguments: false);
              }),
          ListTile(
              title: Text('Address Book'),
              onTap: () {
                Navigator.pushNamed(context, 'addressPage', arguments: false);
              }),
          ListTile(
              title: Text('Language'),
              subtitle: Text(EasyLocalization.of(context)
                  .locale
                  .toLanguageTag()
                  .toString()),
              onTap: () {
                _languageChange(context);
              }),
          ListTile(
              title: Text('Review'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage()),
                );
              }),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              authBloc.logout();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _languageChange(context) {
    String radioItem = EasyLocalization.of(context).locale.toString();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Language Information",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Spacer(),
                      IconButton(
                        icon:
                            Icon(Icons.cancel, color: Colors.orange, size: 25),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      groupValue: radioItem,
                      title: Text('English'),
                      value: 'en_US',
                      onChanged: (val) {
                        setState(() {
                          radioItem = val;
                          EasyLocalization.of(context).locale =
                              Locale('en', 'US');
                        });
                        Navigator.pushReplacementNamed(context, "mainPage");
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      groupValue: radioItem,
                      title: Text('Japanese'),
                      value: 'ja_JP',
                      onChanged: (val) {
                        setState(() {
                          radioItem = val;
                          EasyLocalization.of(context).locale =
                              Locale('ja', 'JP');
                        });
                        Navigator.pushReplacementNamed(context, "mainPage");
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  profileUpdateForm() {
    return StreamBuilder<ProfileResponse>(
        stream: profileBloc.subject.stream,
        builder: (context, AsyncSnapshot<ProfileResponse> snapshot) {
          if (snapshot.hasData) {
            var profile = snapshot.data.profile;
            firstNameController =
                TextEditingController(text: profile.firstName);
            lastNameController = TextEditingController(text: profile.lastName);
            mobileController = TextEditingController(text: profile.mobile);
            email = profile.email;
          }

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
                        Text(tr("Account Information"),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(Icons.cancel,
                              color: Colors.orange, size: 25),
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
                      height: 15,
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
                        RequiredValidator(errorText: "You cannot leave this field empty"),
                      ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          tr(email),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        )),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Mobile Number"),
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
        });
  }

  validateUserProfile(context) async {
    if (_formKey.currentState.validate()) {
      var params = {
        "email": "",
        "first_name": "${firstNameController.text.trim()}",
        "last_name": "${lastNameController.text.trim()}",
        "mobile": "${mobileController.text.trim()}",
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
}
