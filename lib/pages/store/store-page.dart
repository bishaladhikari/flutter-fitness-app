import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(appBar: StoreAppBar(context), body: Body());
  }

  @override
  bool get wantKeepAlive => true;
}
