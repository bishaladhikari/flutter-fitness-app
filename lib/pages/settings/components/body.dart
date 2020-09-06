import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(title: Text('Account Information')),
          ListTile(title: Text('Address Book')),
          ListTile(
              title: Text('Language'),
              subtitle: Text(EasyLocalization.of(context).locale.toString()),
              onTap: () {
                _languageChange(context);
              }),
          ListTile(title: Text('Policies')),
          ListTile(title: Text('About')),
          ListTile(title: Text('Help')),
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
            height: MediaQuery.of(context).size.height * .50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Language Information"),
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
                  Row(children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        groupValue: radioItem,
                        title: Text('English'),
                        value: 'en',
                        onChanged: (val) {
                          setState(() {
                            radioItem = val;
                            EasyLocalization.of(context).locale =
                                Locale('en', 'US');
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        groupValue: radioItem,
                        title: Text('Japanese'),
                        value: 'jp',
                        onChanged: (val) {
                          setState(() {
                            radioItem = val;
                            EasyLocalization.of(context).locale =
                                Locale('jp', 'JP');
                          });
                        },
                      ),
                    ),

                    // RadioListTile(
                    //   groupValue: radioItem,
                    //   title: Text('Japanese'),
                    //   value: 'Item 1',
                    //   onChanged: (val) {},
                    // ),
                    // RadioListTile(
                    //   groupValue: radioItem,
                    //   title: Text('English'),
                    //   value: 'Item 1',
                    //   onChanged: (val) {},
                    // )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 96.0),
                        color: Color(0xFFDA1D21),
                        textColor: Colors.white,
                        child: Text("SUBMIT"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
