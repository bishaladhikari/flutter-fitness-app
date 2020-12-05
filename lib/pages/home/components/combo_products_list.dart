import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/combo_bloc.dart';
import 'package:ecapp/components/combo_product_item.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/response/combo_response.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    comboBloc..getComboProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ComboResponse>(
      stream: comboBloc.subject.stream,
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
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 10, color: Colors.black26),
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
    List<Combo> combos = data.combos;
    return combos.length > 0
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("Combo Products"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kTextColor),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(context, "productViewMore",
                            arguments: 'combo')
                      },
                      child: Text(
                        tr("View All"),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: NPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 280,
                    child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: combos.length,
                        itemBuilder: (context, index) {
                          return ComboProductItem(combo: combos[index]);
                        }),
                  )),
            ],
          )
        : Container();
  }
}
