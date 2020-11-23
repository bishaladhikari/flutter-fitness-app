import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/search_box.dart';
import 'package:flutter/material.dart';
import '../main_page.dart';
import 'components/body.dart';

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
//      ..getProducts(
//          productsByCategoryBloc.category.value,
//          sortBy,
//          minPrice,
//          maxPrice,
//          types);
//    Navigator.of(context).pop();
//  }

//  void _filterProducts(
//      String sortBy, String minPrice, String maxPrice, String types) {
//    productsByCategoryBloc
//      .getProducts(category:productsByCategoryBloc.currentCategory.value, sortBy:sortBy,
//          minPrice:minPrice, maxPrice:maxPrice, types:types);
//    Navigator.of(context).pop();
//  }

  @override
  bool get wantKeepAlive => true;
}
