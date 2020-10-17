import 'package:ecapp/bloc/get_products_byCategory_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsByCategory extends StatefulWidget {
  final String category;
  final String sortBy;
  final String minPrice;
  final String maxPrice;
  final String types;
  ProductsListByCategoryBloc _productsByCategoryBloc;

  get productsByCategoryBloc => _productsByCategoryBloc;

  ProductsByCategory(
      {Key key,
//      this.productsByCategoryBloc,
      this.category,
      this.sortBy,
      this.minPrice,
      this.maxPrice,
      this.types}){
    _productsByCategoryBloc = ProductsListByCategoryBloc();
//    super(key: key);
  }

  @override
  _ProductsByCategoryState createState() => _ProductsByCategoryState(category, sortBy, minPrice, maxPrice, types);
  static _ProductsByCategoryState of(BuildContext context) {
    final _ProductsByCategoryState navigator = context.ancestorStateOfType(const TypeMatcher<_ProductsByCategoryState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does ''not include a ProductDetailPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final String category;
  final String sortBy;
  final String minPrice;
  final String maxPrice;
  final String types;
  ProductsListByCategoryBloc productsByCategoryBloc;

  _ProductsByCategoryState(
      this.category, this.sortBy, this.minPrice, this.maxPrice, this.types);

  @override
  void initState() {
    super.initState();
//    productsByCategoryBloc = ProductsListByCategoryBloc();
//    productsByCategoryBloc = widget._productsByCategoryBloc;
//    widget._productsByCategoryBloc = ProductsListByCategoryBloc();
    widget._productsByCategoryBloc
      ..getCategoryProducts(category, sortBy, minPrice, maxPrice, types);
  }

  @override
  void dispose() {
    super.dispose();
    productsByCategoryBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: widget._productsByCategoryBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
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
          height: 35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
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

  Widget _buildHomeWidget(ProductResponse data) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Product> products = data.products;
    return Container(
        padding: EdgeInsets.only(top: 18),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
//            mainAxisSpacing: 4.0,
//            crossAxisSpacing: 4.0,
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(product: products[index], width: 200.0);
            }));
  }
}
