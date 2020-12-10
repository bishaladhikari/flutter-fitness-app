import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/profile_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UserProfileFormPage extends StatefulWidget {
  @override
  _UserProfileFormPageState createState() => _UserProfileFormPageState();
}

class _UserProfileFormPageState extends State<UserProfileFormPage>
    with SingleTickerProviderStateMixin {
  static final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _validate = false;
  String email;

  @override
  void initState() {
    super.initState();
    profileBloc.userProfile();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.close),
          ),
          title: Text(tr("Account Information"),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child: _buildProfileFromWidget()));
  }

  Widget _buildProfileFromWidget() {
    return StreamBuilder<ProfileResponse>(
        stream: profileBloc.subject.stream,
        builder: (context, AsyncSnapshot<ProfileResponse> snapshot) {
          if (snapshot.hasData) {
            print(['hello', snapshot.data]);
            if (snapshot.data.error != null) {
              return _buildErrorWidget(snapshot.data.error);
            }
            var profile = snapshot.data.profile;
            firstNameController =
                TextEditingController(text: profile.firstName);
            lastNameController = TextEditingController(text: profile.lastName);
            mobileController = TextEditingController(text: profile.mobile);
            email = profile.email;
            return _buildFormWidget();
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr("Error occurred: $error")),
      ],
    ));
  }

  Widget _buildFormWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidate: _validate,
          key: _formKey,
          child: Column(
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
                // textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Last Name"),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "You cannot leave this field empty"),
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
                        fontWeight: FontWeight.bold, color: Colors.black87),
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
                // textInputAction: TextInputAction.done,
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
}
