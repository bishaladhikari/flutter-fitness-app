import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/user.dart';
import 'package:ecapp/models/variant.dart';
import 'package:ecapp/pages/auth/login-page.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/components/search_box.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfo(context), //Product Info
        _buildVariants(context),
        _buildTags(context),
        _buildDescription(context),
      ],
    );
    ;
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.selectedAttribute.discountPrice != null
                ? Text(
                    "\$" + widget.selectedAttribute.sellingPrice,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough),
                  )
                : Container(),
            SizedBox(
              width: 6,
            ),
            Text(
              widget.selectedAttribute.discountPrice != null
                  ? "\$" + widget.selectedAttribute.discountPrice
                  : "\$" + widget.selectedAttribute.sellingPrice,
              style: TextStyle(
                  color: NPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

  _buildVariants(BuildContext context) {
    List<Variant> variants = widget.productDetail.variants;
    final children = <Widget>[];
    for (int i = 0; i < variants?.length ?? 0; i++) {
      if (variants[i] == null) {
        children.add(Center(child: CircularProgressIndicator()));
      } else {
        bool isVariantSelected = widget.selectedVariant.id == variants[i].id;
        children.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: OutlineButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0)),
            child: Text(variants[i].name,
                style: TextStyle(
                    color: isVariantSelected ? kPrimaryColor : kTextColor)),
            onPressed: () {
              var variant = variants[i];
              int index = widget.productDetail.attributes
                  .indexWhere((x) => x.variant?.id == variant.id);
              if (index > -1) {
                widget.productDetailBloc.setSelectedAttribute(
                    widget.productDetail.attributes[index]);
              }
            }, //callback when button is clicked
            borderSide: BorderSide(
              color: isVariantSelected
                  ? kPrimaryColor
                  : Colors.grey.withOpacity(0.3),
              //Color of the border
              style: BorderStyle.solid,
              //Style of the border
              width: 0.8, //width of the border
            ),
          ),
        ));
      }
    }
    return Container(
      decoration: widget.productDetail.variantTitle != null
          ? BoxDecoration(
              border: Border(
              top: BorderSide(width: 1.0, color: Colors.black12),
              bottom: BorderSide(width: 1.0, color: Colors.black12),
            ))
          : BoxDecoration(),
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width,
      child: widget.productDetail.variantTitle != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Available " + widget.productDetail.variantTitle),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: children,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  _buildTags(BuildContext context) {
    List<String> tags = widget.productDetail.tags;
    return widget.productDetail.tags.length > 0
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text(title,
                            style: TextStyle(color: kTextColor)),
                        onPressed: () {}, //callback when button is clicked
                        borderSide: BorderSide(
                          color: kTextColor,
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
    String description = widget.productDetail.description;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
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
//            OverflowBox(
//              child: Html(
//                data: description,
//                //Optional parameters:
////          backgroundColor: Colors.white70,
//                onLinkTap: (url) {
//                  // open url in a webview
//                },
//
//                onImageTap: (src) {
//                  // Display the image in large form.
//                },
//              ),
//            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(
                      context, widget.productDetail.description);
                },
                child: Text(
                  "View More",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
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
