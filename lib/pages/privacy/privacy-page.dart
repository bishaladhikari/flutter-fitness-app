import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Privacy Policy"),
        ),
        body: WebView(
          initialUrl: "http://ecsite.eeeinnovation.com/en/privacy-policy",
        ));
  }
}
