import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/components/sidescroll_card_loading_widget.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:flutter/material.dart';

class NewArrivalsProductsList extends StatefulWidget {
  String storeSlug;

  NewArrivalsProductsList({Key key, this.storeSlug}) : super(key: key);

  @override
  _NewArrivalsProductsListState createState() =>
      _NewArrivalsProductsListState();
}

class _NewArrivalsProductsListState extends State<NewArrivalsProductsList> {
  ProductsListBloc productsListBloc;

  @override
  void initState() {
    productsListBloc = ProductsListBloc();
    productsListBloc.storeSlug.value = widget.storeSlug;
    productsListBloc.types.value = 'popularity';
    productsListBloc.getProducts();
    super.initState();
  }

  @override
  void dispose() {
    productsListBloc.drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productsListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildProductsListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return SideScrollCardLoadingWidget();
        }
      },
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
        height: 300,
        padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              if (index == products.length - 1) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      "productViewMore",
                      arguments: widget.storeSlug == null
                          ? 'new_arrivals'
                          : 'popularity',
                    )
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
            }));
  }
}
