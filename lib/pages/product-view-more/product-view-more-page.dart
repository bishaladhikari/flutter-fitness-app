import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/store_bloc.dart';
import 'package:ecapp/components/combo_list.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:ecapp/models/response/store_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductViewMorePage extends StatefulWidget {
  String types;
  String storeSlug;

  ProductViewMorePage({Key key, this.types, this.storeSlug}) : super(key: key);

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
    } else if (widget.types == 'combo') {
      title = 'Combo Products';
    } else if (widget.types == 'popularity') {
      title = 'Popular Products';
    } else {
      title = "Products";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(tr(title)),
          backgroundColor: Colors.white,
        ),
        body: widget.types != 'combo'
            ? StreamBuilder<StoreResponse>(
                stream: storeBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('has data');
                  } else {
                    print("no data");
                  }
                  // print(snapshot.data.store.storeName);
                  return ProductsList(types: widget.types);
                })
            : ComboList());
  }
}
