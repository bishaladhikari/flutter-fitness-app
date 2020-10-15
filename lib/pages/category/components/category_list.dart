import 'package:ecapp/bloc/get_products_byCategory_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/pages/category/components/products_by_category.dart';
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
  ProductsListByCategoryBloc productsListByCategoryBloc;

  _CategoryListState(this.categories);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        productsListByCategoryBloc..drainStream();
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
              preferredSize: Size.fromHeight(48.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                bottom: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black38,
                  labelColor: NPrimaryColor,
                  indicatorColor: NPrimaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
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
                return ProductsByCategory(category: category.slug,productsByCategoryBloc: productsListByCategoryBloc,);
              }).toList(),
            )),
      ),
    );
  }
}
