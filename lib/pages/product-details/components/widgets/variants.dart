import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/variant.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

// ignore: must_be_immutable
class Variants extends StatefulWidget {
  Variant selectedVariant;
  Attribute selectedAttribute;
  ProductDetail productDetail;
  ProductDetailBloc productDetailBloc;

  Variants({this.productDetail, this.productDetailBloc}) {
    selectedAttribute = productDetail.selectedAttribute;
    selectedVariant = productDetail.selectedAttribute.variant;
  }

  @override
  _VariantsState createState() => _VariantsState();
}

class _VariantsState extends State<Variants> {
  @override
  Widget build(BuildContext context) {
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
    return widget.productDetail.variantTitle != null
        ? Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1.0, color: Colors.black12),
              bottom: BorderSide(width: 1.0, color: Colors.black12),
            )),
            padding: EdgeInsets.all(4.0),
            width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height / 4,
            child: Padding(
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
            ),
          )
        : Container();
  }
}
