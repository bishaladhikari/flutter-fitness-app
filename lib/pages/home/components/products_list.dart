import 'package:fitnessive/bloc/products_bloc.dart';
import 'package:fitnessive/components/product_item.dart';
import 'package:fitnessive/models/product.dart';
import 'package:fitnessive/models/response/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productsBloc.forYou.stream,
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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    List<Product> products = data.products;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: StaggeredGridView.countBuilder(
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
