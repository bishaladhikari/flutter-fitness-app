import 'package:rakurakubazzar/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isAuthenticated = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isAuthenticated = await authBloc.isAuthenticated();
      setState(() {});
    });
  }

  _navigateToUserProfileForm() async {
    // ProfileResponse response = await profileBloc.userProfile();
    // if (response.error == null) {
    Navigator.of(context).pushNamed('accountInformationPage');
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
          isAuthenticated
              ? ListTile(
                  title: Text(tr('Account Information')),
                  onTap: () async {
                    await authBloc.isAuthenticated()
                        ? _navigateToUserProfileForm()
                        : Navigator.of(context).pushNamed('loginPage');
                  })
              : Container(),
          isAuthenticated
              ? ListTile(
                  title: Text(tr('Address Book')),
                  onTap: () {
                    Navigator.pushNamed(context, 'addressPage',
                        arguments: false);
                  })
              : Container(),
          ListTile(
              title: Text(tr('Language')),
              subtitle: Text(EasyLocalization.of(context)
                  .locale
                  .toLanguageTag()
                  .toString()),
              onTap: () {
                _languageChange(context);
              }),
          // ListTile(
          //     title: Text('Review'.tr()),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ReviewPage()),
          //       );
          //     }),
          isAuthenticated
              ? ListTile(
                  title: Text(tr('Change Password')),
                  onTap: () async {
                    _navigateToUserPasswordForm();
                  })
              : Container(),
          isAuthenticated
              ? ListTile(
                  title: Text(tr('Logout')),
                  onTap: () {
                    authBloc.logout();
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  void _languageChange(context) {
    String radioItem = EasyLocalization.of(context).locale.toString();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(tr("Language Information"),
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
                Expanded(
                  child: RadioListTile<String>(
                    groupValue: radioItem,
                    title: Text('Nepali'),
                    value: 'ne_NP',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val;
                        EasyLocalization.of(context).locale =
                            Locale('ne', 'NP');
                      });
                      Navigator.pushReplacementNamed(context, "mainPage");
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    groupValue: radioItem,
                    title: Text('Vietnamese'),
                    value: 'vi_VN',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val;
                        EasyLocalization.of(context).locale =
                            Locale('vi', 'VN');
                      });
                      Navigator.pushReplacementNamed(context, "mainPage");
                    },
                  ),
                ),

              ],
            ),
          );
        });
  }
}
