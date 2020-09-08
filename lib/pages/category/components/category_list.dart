import 'package:ecapp/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categories;

  CategoryList({Key key, @required this.categories}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState(categories);
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  final List<Category> categories;

  _CategoryListState(this.categories);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: SizedBox(
            height: 30,
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Color(0xfff29f39),
              indicatorColor: Color(0xfff29f39),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: categories.map((Category category) {
                return Container(
                    child: new Text(category.name.toUpperCase(),
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)));
              }).toList(),
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 20.0 / 2, bottom: 20.0 * 2.5),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/burger.png"),
                  Container(
                    padding: EdgeInsets.all(20.0 / 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.white.withOpacity(0.23))
                        ]),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 20.0 / 2, bottom: 20.0 * 2.5),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/burger.png"),
                  Container(
                    padding: EdgeInsets.all(20.0 / 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.white.withOpacity(0.23))
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
