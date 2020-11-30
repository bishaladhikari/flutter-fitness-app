import 'package:easy_localization/easy_localization.dart';
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
          elevation: 0,
          title: Text("Store"),
          backgroundColor: Colors.white,
        ),
        body: _buildBodyWidget());
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildStoreProfileWidget(),
        Expanded(child: _buildTabBarWidget()),
      ],
    );
  }

  Widget _buildStoreProfileWidget() {
    return Container(
      color: NPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, top: 10.0, bottom: 10.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/tomato.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Test Store',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 16),
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
                            'Kathmandu',
                            style: TextStyle(fontSize: 12,color: Colors.white),
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
    );
  }

  Widget _buildTabBarWidget() {
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
                  Tab(text: tr("Home")),
                  Tab(text: tr("All Products")),
                  Tab(text: tr("Combo Products")),
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
