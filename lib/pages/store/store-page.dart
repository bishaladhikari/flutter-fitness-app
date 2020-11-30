import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/store_bloc.dart';
import 'package:ecapp/components/combo_list.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/response/store_response.dart';
import 'package:ecapp/pages/store/components/store_home_tab.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  String storeSlug;
  StoreBloc storeBloc;

  StorePage({Key key, this.storeSlug}) {
    storeBloc = StoreBloc();
  }

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.storeBloc.getStoreDetail(widget.storeSlug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: StreamBuilder<StoreResponse>(
              stream: widget.storeBloc.subject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var store = snapshot.data.store;
                  return Text(
                    store.storeName,
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Text("");
                }
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: NPrimaryColor,
        ),
        body: _buildBodyWidget());
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildStoreProfileWidget(context),
        Expanded(child: _buildTabBarWidget()),
      ],
    );
  }

  Widget _buildStoreProfileWidget(context) {
    return StreamBuilder<StoreResponse>(
        stream: widget.storeBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var store = snapshot.data.store;
            var address = store.zipCode == null
                ? ""
                : store.zipCode + store.address == null
                    ? ""
                    : ', ' + store.address + store.city == null
                        ? ""
                        : ', ' + store.city;
            return Container(
              color: NPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 10.0, bottom: 10.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${store.image}"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            store.storeName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
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
                                    address,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
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
          } else {
            return Container(
              color: NPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 10.0, bottom: 10.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/placeholder.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
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
                                    "",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
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
        });
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
