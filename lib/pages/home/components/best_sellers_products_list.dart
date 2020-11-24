import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/products_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/components/search.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BestSellersProductsList extends StatefulWidget {
  const BestSellersProductsList({
    Key key,
  }) : super(key: key);

  @override
  _BestSellersProductsListState createState() =>
      _BestSellersProductsListState();
}

class _BestSellersProductsListState extends State<BestSellersProductsList> {
  @override
  void initState() {
    productsBloc..getBestSellers();
    super.initState();
  }

  @override
  void dispose() {
    productsBloc..drainBestSellersStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productsBloc.bestSellers.stream,
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
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 10, color: Colors.black26),
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
    List<Product> products = data.products;
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
                if (index == products.length - 1) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "productViewMore",
                          arguments: 'best_sellers')
                  },
                    child: Container(
                        width: 160.0,
                        height: 270,
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 20,
                              color: Color(0xFFB0CCE1).withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                              tr("More"),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: NPrimaryColor),
                            ))),
                  );
                }
                return ProductItem(product: products[index]);
              }),
        ));
  }
}
