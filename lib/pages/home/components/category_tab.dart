import 'package:ecapp/pages/home/components/best_sellers_products_list.dart';
import 'package:ecapp/pages/home/components/new_arrivals_products_list.dart';
import 'package:ecapp/pages/home/components/top_rated_products_list.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white10,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                isScrollable: true,
                labelColor: NPrimaryColor,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: "Best Sellers"),
                  Tab(text: "New Arrivals"),
                  Tab(text: "Top Rated"),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              BestSellersProductsList(),
              NewArrivalsProductsList(),
              TopRatedProductsList(),
            ],
          ),
        ),
      ),
    );
  }
}
