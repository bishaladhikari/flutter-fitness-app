import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class StorePage extends StatefulWidget {
  String storeSlug;

  StorePage({Key key, this.storeSlug}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  String storeSlug;

  final List<String> orderTitleList = [
    'All',
    'Pending',
    'In Progress',
  ];

  TabController _tabController;

  // @override
  // Widget build(BuildContext context) {
  //   super.build(context);
  //   return Scaffold(appBar: StoreAppBar(context), body: Body());
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'All Products',
                ),
                Tab(
                  text: 'Combo Products',
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

  @override
  bool get wantKeepAlive => true;
}
