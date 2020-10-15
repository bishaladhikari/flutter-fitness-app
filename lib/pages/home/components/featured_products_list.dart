import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/pages/details/details-page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'item_card.dart';

class FeaturedProductsList extends StatefulWidget {
  const FeaturedProductsList({
    Key key,
  }) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<FeaturedProductsList> {
  @override
  void initState() {
    super.initState();
//    featuredProductsBloc..getFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productsBloc.featured.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildProductsListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    var width = MediaQuery.of(context).size.width - 16;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black26,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.white70,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(height: 220, width: 150, color: Colors.black26),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Container(height: 220, width: 150, color: Colors.black26),
                ],
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
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
    var size = MediaQuery.of(context).size;

//    final double itemHeight = (size.height) / 2.5;
//    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Product> products = data.products;
//    return Text(products[0].name);

    return Container(
        padding: EdgeInsets.only(top: 18),
        child: SizedBox(
          height: 240,
          child: ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(product: products[index]);
              }),
        ));
  }
}
