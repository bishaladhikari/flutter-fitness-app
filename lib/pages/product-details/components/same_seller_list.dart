import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/material.dart';

class SameSellerList extends StatefulWidget {
  final String slug;
  const SameSellerList({
    Key key,
    this.slug
  }) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<SameSellerList> {
  ProductDetailBloc productDetailBloc;
  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    productDetailBloc.getSameSellerProduct(widget.slug);
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
    var size = MediaQuery.of(context).size;

//    final double itemHeight = (size.height) / 2.5;
//    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Product> products = data.products;
//    return Text(products[0].name);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(top: 18),
            child: SizedBox(
              height: 240,
              child: ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index],);
                  }),
            )
        ),
      ],
    );
  }
}
