import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          
          ListTile(title: Text('Account Information')),
          ListTile(title: Text('Address Book')),   
          ListTile(title: Text('Language')),
           
          ListTile(title: Text('Policies')),
          ListTile(title: Text('About')),
          ListTile(title: Text('Help')),
          
        ],
        
      ),
     
    );
  }
}
