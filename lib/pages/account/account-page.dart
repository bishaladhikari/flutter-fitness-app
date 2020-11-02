import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(appBar: accountAppBar(context), body: Body());
  }

  @override
  bool get wantKeepAlive => true;
}
