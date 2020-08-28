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
    return Scaffold(
      appBar: AccountAppBar(context),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
