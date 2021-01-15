import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/profile_bloc.dart';
import 'package:ecapp/models/response/profile_response.dart';
import 'package:ecapp/pages/review/review-page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  _navigateToUserProfileForm() async {
    // ProfileResponse response = await profileBloc.userProfile();
    // if (response.error == null) {
      Navigator.of(context)
          .pushNamed('accountInformationPage');
    // }
  }

  _navigateToUserPasswordForm() async {
    await authBloc.isAuthenticated() == true
        ? Navigator.of(context).pushNamed('userPasswordForm')
        : Navigator.of(context).pushNamed('loginPage');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
              title: Text('Account Information'.tr()),
              onTap: () async {
                await authBloc.isAuthenticated()
                    ? _navigateToUserProfileForm()
                    : Navigator.of(context).pushNamed('loginPage');
              }),
          ListTile(
              title: Text('Address Book'.tr()),
              onTap: () {
                Navigator.pushNamed(context, 'addressPage', arguments: false);
              }),
          ListTile(
              title: Text('Language'.tr()),
              subtitle: Text(EasyLocalization.of(context)
                  .locale
                  .toLanguageTag()
                  .toString()),
              onTap: () {
                _languageChange(context);
              }),
          ListTile(
              title: Text('Review'.tr()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage()),
                );
              }),
          ListTile(
              title: Text('Change Password'.tr()),
              onTap: () async {
                _navigateToUserPasswordForm();
              }),
          ListTile(
            title: Text('Logout'.tr()),
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
}
