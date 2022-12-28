import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/bloc/auth_bloc.dart';
import 'package:fitnessive/bloc/banner_bloc.dart';
import 'package:fitnessive/bloc/cart_bloc.dart';
import 'package:fitnessive/bloc/categories_bloc.dart';
import 'package:fitnessive/bloc/main_bloc.dart';
import 'package:fitnessive/bloc/products_bloc.dart';
import 'package:fitnessive/components/no_internet_widget.dart';
import 'package:fitnessive/models/meta.dart';
import 'package:flutter/material.dart';
import '../main_page.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Don't show the leading button
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    MainPage.of(context).scaffoldKey.currentState.openDrawer();
                  }),
              Container()
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
//      appBar: homeAppBar(context),
//      bottomNavigationBar: BottomNavBar(),
        body: FutureBuilder(
          future: mainBloc.isInternetAvailable(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return snapshot.data
                  ? Body()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NoInternetWidget(),
                          GestureDetector(
                              onTap: () {

                              },
                              child: Text(
                                tr("Retry"),
                                style: TextStyle(color: Colors.blueAccent,fontSize: 16),
                              ))
                        ],
                      ),
                    );
            return Container();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Widget> _buildBody() async {
    return await mainBloc.isInternetAvailable() ? Body() : NoInternetWidget();
  }
}
