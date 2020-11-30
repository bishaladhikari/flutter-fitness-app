import 'package:ecapp/bloc/banner_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/categories_bloc.dart';
import 'package:ecapp/bloc/products_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/pages/home/components/category_tab.dart';
import 'package:ecapp/pages/home/components/combo_products_list.dart';
import 'package:ecapp/pages/home/components/products_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'category_chips_list.dart';
import 'discount_card.dart';
import 'featured_products_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int page = 1;
  ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition > triggerFetchMoreSize) {
        Meta meta = productsBloc.forYou.value.meta;
        if (page < meta.lastPage) {
          page++;
          productsBloc.page.value = page;
          productsBloc..getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        productsBloc.page.value = 1;
        bannerBloc.drainStream();
        categoryBloc.drainStream();
        productsBloc.drainNewArrivalsStream();
        productsBloc.drainBestSellersStream();
        productsBloc.drainTopRatedStream();
        bannerBloc.getBanners();
        categoryBloc.getCategories();
        productsBloc.getFeaturedProducts();
        productsBloc.getBestSellers();
        productsBloc.getProducts();
        productsBloc.getNewArrivals();
        cartBloc..getCart();
        return true;
      },

      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CategoryChipsList(),
            DiscountCard(),
            CategoryTab(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Featured Products",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
                  ),
                ],
              ),
            ),
            FeaturedProductsList(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Combo Products",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
                  ),
                ],
              ),
            ),
            ComboProductsList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Products for you",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
              ),
            ),
            ProductsList(),
          ],
        ),
      ),
    );
  }
}
