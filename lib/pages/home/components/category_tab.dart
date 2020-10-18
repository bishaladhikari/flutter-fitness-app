import 'package:ecapp/bloc/get_categories_bloc.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:ecapp/pages/home/components/best_sellers_products_list.dart';
import 'package:ecapp/pages/home/components/featured_products_list.dart';
import 'package:ecapp/pages/home/components/new_arrivals_products_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'category_item.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white10,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: "Best Sellers"),
                  Tab(text: "New Arrivals"),
                  Tab(text: "Featured Products"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              BestSellersProductsList(),
              NewArrivalsProductsList(),
              FeaturedProductsList(),
            ],
          ),
        ),
      ),
    );
  }
}
