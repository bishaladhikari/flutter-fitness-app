import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/pages/details/details-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'item_card.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({
    Key key,
  }) : super(key: key);

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
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Product> products = data.products;
    return Container(
        padding: EdgeInsets.only(top: 18),
        child: StaggeredGridView.countBuilder(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
////                childAspectRatio: (itemWidth / itemHeight)
//            ),
            crossAxisCount:4,
            staggeredTileBuilder: (int index) =>
            StaggeredTile.fit(2),
//            mainAxisSpacing: 4.0,
//            crossAxisSpacing: 4.0,
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(product: products[index],width: 200.0);
            })
    );
  }
}
