import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductViewMorePage extends StatefulWidget {
  String types;

  ProductViewMorePage({Key key, this.types}) : super(key: key);

  @override
  _ProductViewMorePageState createState() => _ProductViewMorePageState();
}

class _ProductViewMorePageState extends State<ProductViewMorePage> {
  var title;

  @override
  Widget build(BuildContext context) {
    if (widget.types == 'new_arrivals') {
      title = 'New Arrivals';
    } else if (widget.types == 'top_rated') {
      title = 'Top Rated';
    } else if (widget.types == 'best_sellers') {
      title = 'Best Sellers';
    } else if (widget.types == 'featured') {
      title = 'Featured Products';
    } else {
      title = "Products";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(tr(title)),
          backgroundColor: Colors.white,
        ),
        body: ProductsList(types: widget.types));
  }
}
