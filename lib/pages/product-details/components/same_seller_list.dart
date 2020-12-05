import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/material.dart';

class SameSellerList extends StatefulWidget {
  final String slug;
  final ProductDetail productDetail;
  final bool isCombo;

  const SameSellerList(
      {Key key, this.slug, this.isCombo = false, this.productDetail})
      : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<SameSellerList> {
  ProductDetailBloc productDetailBloc;

  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    productDetailBloc.getSameSellerProduct(
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
      stream: productDetailBloc.fromSameSeller.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildProductsListWidget(context, snapshot.data);
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

  Widget _buildProductsListWidget(context, ProductResponse data) {
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
                        tr("From same seller"),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 306,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            product: products[index],
                          );
                        }),
                  )),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "storePage",
                        arguments: widget.productDetail.storeSlug);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tr("Visit store"),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: NPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
