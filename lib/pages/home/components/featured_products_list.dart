import 'package:ecapp/bloc/featured_products_list_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/featured_product_response.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/pages/details/details-page.dart';
import 'package:flutter/material.dart';
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
    featuredProductsBloc..getFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FeaturedProductResponse>(
      stream: featuredProductsBloc.subject.stream,
      builder: (context, AsyncSnapshot<FeaturedProductResponse> snapshot) {
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

  Widget _buildProductsListWidget(FeaturedProductResponse data) {
    var size = MediaQuery.of(context).size;

//    final double itemHeight = (size.height) / 2.5;
//    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Product> products = data.products;
    print("hello boss"+ products[0].name);
//    return Text(products[0].name);


    return Container(
        padding: EdgeInsets.only(top: 18),
        child: SizedBox(
          height: 250,
          child: ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ProductItem(product: products[index]),
                );
              }),
        )
    );
  }
}
