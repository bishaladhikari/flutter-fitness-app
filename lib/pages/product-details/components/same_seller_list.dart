import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/material.dart';

class SameSellerList extends StatefulWidget {
  final String slug;
  final bool isCombo;

  const SameSellerList({Key key, this.slug, this.isCombo = false})
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
    return Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 280,
          child: ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (index == products.length - 1) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "fromSameSellerPage",
                          arguments: widget.slug)
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
                return ProductItem(
                  product: products[index],
                );
              }),
        ));
  }
}
