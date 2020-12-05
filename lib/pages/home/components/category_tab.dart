import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/pages/home/components/best_sellers_products_list.dart';
import 'package:ecapp/pages/home/components/new_arrivals_products_list.dart';
import 'package:ecapp/pages/home/components/top_rated_products_list.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375.0,
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
                  Tab(text: tr("Best Sellers")),
                  Tab(text: tr("New Arrivals")),
                  Tab(text: tr("Top Rated")),
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
