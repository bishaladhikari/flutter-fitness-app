import 'package:ecapp/components/combo_list.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  String storeSlug;

  StorePage({Key key, this.storeSlug});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
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
              ProductsList(storeSlug: widget.storeSlug),
              ComboList(storeSlug: widget.storeSlug),
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
