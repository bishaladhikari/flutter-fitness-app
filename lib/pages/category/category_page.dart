import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Svg.picture,
//      appBar: AccountAppBar(context),
      body: CategoryBody(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
