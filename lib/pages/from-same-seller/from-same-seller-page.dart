import 'package:rakurakubazzar/bloc/product_detail_bloc.dart';
import 'package:rakurakubazzar/components/product_item.dart';
import 'package:rakurakubazzar/models/meta.dart';
import 'package:rakurakubazzar/models/product.dart';
import 'package:rakurakubazzar/models/response/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FromSameSellerPage extends StatefulWidget {
  final String slug;
  final bool isCombo;

  FromSameSellerPage({Key key, this.slug, this.isCombo = false})
      : super(key: key);

  @override
  _FromSameSellerPageState createState() => _FromSameSellerPageState();
}

class _FromSameSellerPageState extends State<FromSameSellerPage> {
  ProductDetailBloc productDetailBloc;
  int page = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    productDetailBloc = ProductDetailBloc();
    sameSellerProduct();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition > triggerFetchMoreSize) {
        Meta meta = productDetailBloc.fromSameSeller.value.meta;
        if (page < meta.lastPage) {
          page++;
          sameSellerProduct();
        }
      }
    });

    super.didChangeDependencies();
  }

  sameSellerProduct() {
    productDetailBloc.getSameSellerProduct(
        slug: widget.slug, isCombo: widget.isCombo, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("From Same Seller"),
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<ProductResponse>(
          stream: productDetailBloc.fromSameSeller.stream,
          builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildProductsListWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ));
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
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
        padding: EdgeInsets.only(top: 18),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(product: products[index], width: 180.0);
            }));
  }
}
