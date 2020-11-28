import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/store/components/app_bar.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorWeight: 10.0,
              tabs: <Widget>[
                Tab(
                  text: 'Incoming Call',
                ),
                Tab(
                  text: 'Outgoing Call',
                ),
                Tab(
                  text: 'Missed Call',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildListViewWithName('Incoming Call'),
              _buildListViewWithName('Outgoing Call'),
              _buildListViewWithName('Missed Call'),
            ],
          )),
    );
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              title: Text(s + ' $index'),
            ));
  }
}
