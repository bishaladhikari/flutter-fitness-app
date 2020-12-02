import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelatedProductsList extends StatefulWidget {
  final String slug;
  final bool isCombo;

  RelatedProductsList({Key key, this.slug, this.isCombo = false})
      : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<RelatedProductsList> {
  ProductDetailBloc productDetailBloc;

  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    productDetailBloc.getRelatedProduct(
        slug: widget.slug, isCombo: widget.isCombo);
    super.initState();
  }

  @override
  void dispose() {
    productDetailBloc..drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productDetailBloc.related.stream,
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
    List<Product> products = data.products;
    return products.length > 0
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "You may also like",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                        textAlign: TextAlign.start,
                      ),
                    ),
//                    Expanded(
//                      child: GestureDetector(
//                        onTap: () {
//                          print("Clicked");
//                        },
//                        child: Text(
//                          "View All",
//                          style: TextStyle(fontSize: 16.0, color: Colors.blue),
//                          textAlign: TextAlign.end,
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 280,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(product: products[index]);
                        }),
                  )),
            ],
          )
        : Container();
  }
}
