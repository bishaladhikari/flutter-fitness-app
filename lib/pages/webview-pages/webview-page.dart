import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/models/info_page.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final InfoPage infoPage;

  const WebViewPage({Key key, this.infoPage}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  String selectedLocale;

  @override
  Widget build(BuildContext context) {
    if (EasyLocalization.of(context).locale.languageCode == 'ne') {
      selectedLocale = 'np';
    } else if (EasyLocalization.of(context).locale.languageCode == 'ja') {
      selectedLocale = 'jp';
    } else {
      selectedLocale =
          EasyLocalization.of(context).locale.languageCode.toString();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          tr(widget.infoPage.title),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(children: [
        WebView(
          key: _key,
          initialUrl: Repository().baseUrl +
              "/" +
              this.selectedLocale +
              "/" +
              widget.infoPage.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ]),
    );
  }
}
