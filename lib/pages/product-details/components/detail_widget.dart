import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/components/search.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/variant.dart';
import 'package:ecapp/pages/product-details/components/widgets/variants.dart';
import 'package:ecapp/pages/product-details/components/widgets/price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailWidget extends StatefulWidget {
  Variant selectedVariant;
  Attribute selectedAttribute;
  ProductDetail productDetail;
  ProductDetailBloc productDetailBloc;

  DetailWidget({this.productDetail, this.productDetailBloc}) {
    selectedAttribute = productDetail.selectedAttribute;
    selectedVariant = productDetail.selectedAttribute.variant;
  }

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
//  _ProductInfoState(productDetail);
  bool _showFullText=false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductPrice(productDetail: widget.productDetail), //Product Info
        Variants(
            productDetail: widget.productDetail,
            productDetailBloc: widget.productDetailBloc),
        _buildTags(context),
        _buildDescription(context),
      ],
    );
  }

  _buildTags(BuildContext context) {
    List<String> tags = widget.productDetail.tags;
    return widget.productDetail.tags.length > 0
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.topLeft, child: Text("Tags")),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: tags.map((title) {
                    return Container(
                      padding: const EdgeInsets.all(6.0),
                      child: OutlineButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6))),
                        onPressed: () {
                          showSearch(context: context, delegate: Search(),query: title);
//                          Search().showResults(context);
                        }, //callback when button is clicked
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.4),
                          //Color of the border
                          style: BorderStyle.solid,
                          //Style of the border
                          width: 0.8, //width of the border
                        ),
                      ),
                    );
                  }).toList()),
                ),
              ],
            ),
          )
        : Container();
  }


  _buildDescription(BuildContext context) {
    String descText = widget.productDetail.description;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Description",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: kTextColor)),
          Html(data:descText),
          SizedBox(
            height: 8,
          ),
          // Center(
          //   child: GestureDetector(
          //     onTap: () {
          //       _settingModalBottomSheet(
          //           context, widget.productDetail.description);
          //     },
          //     child: Text(
          //       "View More",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.blueGrey,
          //           fontSize: 16),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context, description) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Html(data: description),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
