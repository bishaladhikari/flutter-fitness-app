import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
//      backgroundColor: Svg.picture,
      appBar: accountAppBar(context),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
