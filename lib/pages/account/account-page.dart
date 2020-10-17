import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.01),
      appBar: AccountAppBar(context),
      body: Body()
    );
  }

  @override
  bool get wantKeepAlive => true;
}
