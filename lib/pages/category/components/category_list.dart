import 'package:rakurakubazzar/bloc/categories_bloc.dart';
import 'package:rakurakubazzar/bloc/products_list_bloc.dart';
import 'package:rakurakubazzar/components/products_list.dart';
import 'package:rakurakubazzar/constants.dart';
import 'package:rakurakubazzar/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categories;

  CategoryList({Key key, @required this.categories}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState(categories);

  static _CategoryListState of(BuildContext context) {
    final _CategoryListState navigator =
        context.ancestorStateOfType(const TypeMatcher<_CategoryListState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a CategoryList.');
      }
      return true;
    }());

    return navigator;
  }
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  final List<Category> categories;

//  ProductsListByCategoryBloc productsListBloc;

  _CategoryListState(this.categories);

  TabController _tabController;
  ProductsListBloc productsListBloc;

  changeTabIndex(index) {
    setState(() {
      _tabController.animateTo(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
    categoryBloc.selectedCategoryIndex.listen((index) {
      _tabController.animateTo(index);
    });
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
//        if (_tabController.index != _tabController.previousIndex)
//          // Tab Changed swiping to a new tab
//          categoryBloc.productsListBloc = productsListBloc;
////        productsListBloc = ProductsListByCategoryBloc();
////        categoryBloc.productsListBloc = productsListBloc;
////        categoryBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
//    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                bottom: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black38,
                  labelColor: NPrimaryColor,
                  indicatorColor: NPrimaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  controller: _tabController,
                  tabs: categories.map((Category category) {
                    return Container(
                        padding: const EdgeInsets.all(6.0),
                        child: new Text(category.name.toUpperCase(),
                            style: new TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)));
                  }).toList(),
                  labelPadding: EdgeInsets.all(6.0),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: categories.map((Category category) {
                return ProductsList(category: category.slug);
              }).toList(),
            )),
      ),
    );
  }
}
