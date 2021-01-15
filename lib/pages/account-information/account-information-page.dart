import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/profile_bloc.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/profile-form-widget.dart';
import 'package:ecapp/constants.dart';

class AccountInformationPage extends StatefulWidget {


  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage>
    with SingleTickerProviderStateMixin {
  // static final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  bool _validate = false;
  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  getUserProfile() async {
    await profileBloc.userProfile();
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc.drainStream();
    // firstNameController.dispose();
    // lastNameController.dispose();
    // mobileController.dispose();
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
            // print(['hello', snapshot.data]);
            if (snapshot.data.error != null) {
              return _buildErrorWidget(snapshot.data.error);
            }
            var profile = snapshot.data.profile;
            return ProfileFormWidget(profile:profile);
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
          height: 3.0,
          // width: 35.0,
          child: LinearProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(NPrimaryColor),
            minHeight: 4.0,
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

}
