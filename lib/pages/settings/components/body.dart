// import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/details/components/add-address.dart';
import 'package:ecapp/pages/details/components/add_location.dart';
import 'package:flutter/material.dart';
// import 'package:ecapp/components/search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          ListTile(title: Text('Account Information')),
          ListTile(
              title: Text('Address Book'),
           onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationPage()),
                );   
              

                ListTile(title: Text('Language'));

                ListTile(title: Text('Policies'));
                ListTile(title: Text('About'));
                ListTile(title: Text('Help'));
              })]));
            
            
            }
            
  }

