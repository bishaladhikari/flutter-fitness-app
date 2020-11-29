import 'package:ecapp/bloc/products_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/pages/home/components/new_arrivals_products_list.dart';
import 'package:ecapp/pages/home/components/products_list.dart';
import 'package:flutter/material.dart';

class StoreHomeTab extends StatefulWidget {
  String storeSlug;
  ProductsListBloc productsListBloc;

  StoreHomeTab({Key key, this.storeSlug}) {
    productsListBloc = ProductsListBloc();
  }

  @override
  _StoreHomeTabState createState() => _StoreHomeTabState();
}

class _StoreHomeTabState extends State<StoreHomeTab> {
  int page = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    widget.productsListBloc.storeSlug.value = widget.storeSlug;
    widget.productsListBloc.page.value = page;
    widget.productsListBloc.types.value = 'products_for_you';
    widget.productsListBloc.getProducts();
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition > triggerFetchMoreSize) {
        Meta meta = widget.productsListBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          widget.productsListBloc.page.value = page;
          widget.productsListBloc..getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10.0),
            child: Text(
              "Popular Products",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
            ),
          ),
          NewArrivalsProductsList(storeSlug: widget.storeSlug),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10.0),
            child: Text(
              "Products for you",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
            ),
          ),
          ProductsList(),
        ],
      ),
    );
  }
}
