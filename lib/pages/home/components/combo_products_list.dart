import 'package:ecapp/bloc/combo_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/combo_product_item.dart';
import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/models/response/featured_product_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/pages/details/details-page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'item_card.dart';

class ComboProductsList extends StatefulWidget {
  const ComboProductsList({
    Key key,
  }) : super(key: key);

  @override
  _ComboProductsListState createState() => _ComboProductsListState();
}

class _ComboProductsListState extends State<ComboProductsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ComboResponse>(
      stream: comboBloc.combo.stream,
      builder: (context, AsyncSnapshot<ComboResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildComboProductsListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    var width = MediaQuery.of(context).size.width - 16;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black26,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.white70,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(height: 220, width: 150, color: Colors.black26),
                ],
              ),
              SizedBox(width: 15),
              Column(
                children: [
                  Container(height: 220, width: 150, color: Colors.black26),
                ],
              ),
              SizedBox(width:15 ),
              Column(
                children: [
                  Container(height: 220, width: 10, color: Colors.black26),
                ],
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildComboProductsListWidget(ComboResponse data) {
    var size = MediaQuery.of(context).size;

//    final double itemHeight = (size.height) / 2.5;
//    final double itemWidth = size.width / 2;
    final orientation = MediaQuery.of(context).orientation;
    List<Combo> products = data.products;
//    return Text(products[0].name);

    return Container(
        padding: EdgeInsets.only(top: 18),
        child: SizedBox(
          height: 280,
          child: ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ComboProductItem();
              }),
        ));
  }
}
