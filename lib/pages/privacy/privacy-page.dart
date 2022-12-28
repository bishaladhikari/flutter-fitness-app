import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(tr("Privacy Policy")),
        ),
        body:Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:  Repository().baseUrl+"/en/privacy-policy",
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ));
  }
}
