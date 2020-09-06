import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';
import 'package:ecapp/bloc/get_categories_bloc.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    categoryBloc..getCategories();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/CartOutBold.svg"),
            color: Colors.black,
            onPressed: () {},
          ),
          SizedBox(width: 20.0 / 2)
        ],
      ),
      body: CategoryBody(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
