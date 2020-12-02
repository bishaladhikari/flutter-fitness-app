import 'package:ecapp/components/combo_list.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:flutter/material.dart';

class StoreTabs extends StatefulWidget {
  String storeSlug;

  StoreTabs({Key key, this.storeSlug});

  @override
  _StoreTabsState createState() => _StoreTabsState();
}

class _StoreTabsState extends State<StoreTabs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: TabBar(
              tabs: [
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
        ),
      ),
    );
  }
}
