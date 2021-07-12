import 'package:easy_localization/easy_localization.dart';
import 'package:rakurakubazzar/constants.dart';
import 'package:rakurakubazzar/pages/main_page.dart';
import 'package:flutter/material.dart';

import 'components/orders_by_status.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersListPageState createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage>
    with SingleTickerProviderStateMixin {
  final List<String> orderTitleList = [
    'All',
    'Pending',
    'In Progress',
    'Ready For Shipping',
    'Shipped',
    'Delivered',
    'Cancelled',
    'Failed Delivery'
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text((tr("Orders"))),
            backgroundColor: Colors.white,
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: NPrimaryColor,
              labelColor: NPrimaryColor,
              unselectedLabelColor: Colors.black38,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: orderTitleList.map((title) {
                return Container(
                    padding: const EdgeInsets.all(6.0),
                    child: new Text(tr(title),
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)));
              }).toList(),
            )),
        body: Center(
          child: TabBarView(
              controller: _tabController,
              children: orderTitleList.map((title) {
                return OrdersByStatus(status: title);
              }).toList()),
        ));
  }
}
