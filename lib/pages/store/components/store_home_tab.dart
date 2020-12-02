import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/pages/home/components/new_arrivals_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          widget.productsListBloc.getProducts();
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
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
              tr("Products for you"),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
            ),
          ),
          StreamBuilder<ProductResponse>(
            stream: widget.productsListBloc.subject.stream,
            builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildProductsListWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildProductsListWidget(ProductResponse data) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    List<Product> products = data.products;
    return Container(
        padding: EdgeInsets.only(top: 8),
        child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(8),
            crossAxisCount: 4,
            staggeredTileBuilder: isMobile
                ? (int index) => StaggeredTile.fit(2)
                : (int index) => StaggeredTile.fit(1),
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(product: products[index], width: 180.0);
            }));
  }
}
