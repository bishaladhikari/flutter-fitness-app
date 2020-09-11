import 'package:ecapp/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    return Container(
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                bottom: TabBar(
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
            body: TabBarView(
              controller: _tabController,
              children: categories.map((Category category) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: new StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _buildProduct(context),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.fit(2)),
                );
              }).toList(),
            )),
      ),
    );
  }

  @override
  Widget _buildProduct(BuildContext context) => Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    Image.asset("assets/images/burger.png", fit: BoxFit.cover),
              ),
              Material(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(8)),
                ),
                child: Icon(Icons.image, color: Colors.black.withOpacity(0.8)),
              )
            ],
          ),
          _buildProductInfo(context),
        ],
      );

  Widget _buildProductInfo(BuildContext context) => Container(
        // margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("\$469",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("\$469",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("10\% Off",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ),
              ],
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("T-shirt with Blade print",
                  style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
      );

  @override
  Widget build1(BuildContext context) {
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
