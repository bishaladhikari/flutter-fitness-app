import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiscountInfo {
  final image;
  final imageUrl;
  final url;
  final String caption;
  DiscountInfo({Key key, this.image, this.imageUrl, this.url, this.caption});
}

class DiscountView extends StatefulWidget {
  final discountInfo;
  DiscountView({Key key, this.discountInfo});
  @override
  _DiscountViewState createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(widget.discountInfo.caption),
        ),
        body:Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:  widget.discountInfo.url,
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
