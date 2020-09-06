import 'package:ecapp/model/Category.dart';
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
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Category",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: SizedBox(
            height: 30,
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.red,
              controller: _tabController,
              tabs: categories.map((Category category) {
                return Container(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: new Text(category.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)));
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
