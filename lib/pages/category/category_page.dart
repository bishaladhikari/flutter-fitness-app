import 'package:ecapp/bloc/products_by_category_bloc.dart';
import 'package:ecapp/components/search_box.dart';
import 'package:ecapp/pages/category/components/filter_list.dart';
import 'package:ecapp/pages/category/components/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';
import '../main_page.dart';
import 'components/body.dart';
import 'package:ecapp/bloc/categories_bloc.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
//  ProductsListByCategoryBloc productsByCategoryBloc;
  Map<String, bool> values = {
    'featured': false,
    'best_sellers': false,
    'new_arrivals': false,
    'top_rated': false,
  };

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
//    productsByCategoryBloc = ProductsListByCategoryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  MainPage.of(context).scaffoldKey.currentState.openDrawer();
                }
            ),
            SearchBox()
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CategoryBody(),
    );
  }



//  void _sortProducts(context,String sortBy) {
//    const minPrice = '';
//    const maxPrice = '';
//    const types = '';
//
//    productsByCategoryBloc
//      ..getCategoryProducts(
//          productsByCategoryBloc.category.value,
//          sortBy,
//          minPrice,
//          maxPrice,
//          types);
//    Navigator.of(context).pop();
//  }

  void _filterProducts(
      String sortBy, String minPrice, String maxPrice, String types) {
    productsByCategoryBloc
      ..getCategoryProducts(productsByCategoryBloc.category.value, sortBy,
          minPrice, maxPrice, types);
    Navigator.of(context).pop();
  }

  @override
  bool get wantKeepAlive => true;
}
