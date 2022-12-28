import 'package:fitnessive/bloc/main_bloc.dart';
import 'package:fitnessive/bloc/products_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/meta.dart';
import 'package:fitnessive/pages/home/components/category_tab.dart';
import 'package:fitnessive/pages/home/components/combo_products_list.dart';
import 'package:fitnessive/pages/home/components/products_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
          productsBloc.getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        mainBloc.refresh();
        return true;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(),
            DiscountCard(),
            CategoryTab(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("Featured Products"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kTextColor),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "productViewMore",
                          arguments: 'featured')
                    },
                    child: Text(
                      tr("View All"),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: NPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            FeaturedProductsList(),
            SizedBox(height: 5),
            ComboProductsList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                tr("Products for you"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kTextColor),
              ),
            ),
            ProductsList(),
          ],
        ),
      ),
    );
  }
}
