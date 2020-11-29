import 'package:ecapp/components/combo_list.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/pages/store/components/store_home_tab.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [_storeProfileBuild(), _tabbarBuild()],
      ),
    );
  }

  Widget _storeProfileBuild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.blueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 10.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/tomato.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Test Store',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 17,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Kathmandyu',
                              style:
                                  TextStyle(wordSpacing: 2, letterSpacing: 4),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabbarBuild() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white10,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                isScrollable: true,
                labelColor: NPrimaryColor,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "All Products"),
                  Tab(text: "Combo Products"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              StoreHomeTab(storeSlug: widget.storeSlug),
              ProductsList(storeSlug: widget.storeSlug),
              ComboList(storeSlug: widget.storeSlug),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
