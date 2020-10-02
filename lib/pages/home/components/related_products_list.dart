import 'package:ecapp/bloc/related_products_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/related_product_response.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:flutter/material.dart';

class RelatedProductsList extends StatefulWidget {
  const RelatedProductsList({
    Key key,
  }) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<RelatedProductsList> {
  @override
  void initState() {
    super.initState();
    relatedProductsBloc..getRelatedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RelatedProductResponse>(
      stream: relatedProductsBloc.subject.stream,
      builder: (context, AsyncSnapshot<RelatedProductResponse> snapshot) {
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

  Widget _buildProductsListWidget(RelatedProductResponse data) {
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
        )
    );
  }
}
