import 'package:rakurakubazzar/bloc/combo_detail_bloc.dart';
import 'package:rakurakubazzar/models/attribute.dart';
import 'package:rakurakubazzar/models/combo_detail.dart';
import 'package:rakurakubazzar/models/product.dart';
import 'package:rakurakubazzar/models/variant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailWidget extends StatefulWidget {
  Variant selectedVariant;
  Attribute selectedAttribute;
  ComboDetail comboDetail;
  ComboDetailBloc comboDetailBloc;

  DetailWidget({this.comboDetail, this.comboDetailBloc});

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
        _buildAttributes(context),
//        _buildDescription(context),
      ],
    );
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
//            widget.selectedAttribute.discountPrice != null
//                ? Text(
//                    "\¥" + widget.selectedAttribute.sellingPrice,
//                    style: TextStyle(
//                        color: Colors.black54,
//                        fontSize: 18,
//                        decoration: TextDecoration.lineThrough),
//                  )
//                : Container(),
//            SizedBox(
//              width: 6,
//            ),
//            Text(
//              widget.selectedAttribute.discountPrice != null
//                  ? "\¥" + widget.selectedAttribute.discountPrice
//                  : "\¥" + widget.selectedAttribute.sellingPrice,
//              style: TextStyle(
//                  color: NPrimaryColor,
//                  fontSize: 18,
//                  fontWeight: FontWeight.w700),
//            )
          ],
        ),
      ),
    );
  }

  _buildAttributes(BuildContext context) {
    List<Attributes> attributes = widget.comboDetail.attributes;
    final children = <Widget>[];
    for (int i = 0; i < attributes?.length ?? 0; i++) {
      if (attributes[i] == null) {
        children.add(Center(child: CircularProgressIndicator()));
      } else {
        children.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: OutlineButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0)),
            child: Text(attributes[i].productName,
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              Product product = Product();
              product.name = attributes[i].productName;
              product.slug = attributes[i].slug;
              product.imageThumbnail = attributes[i].images[0].imageThumbnail;
              product.image = attributes[i].images[0].imageThumbnail;
              product.heroTag = attributes[i].heroTag;

              Navigator.pushNamed(context, "productDetailPage",
                  arguments: product);
            }, //callback when button is clicked
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
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
            Text(
              tr("What's in the bundle?"),
              style: TextStyle(color: Colors.black),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }

//  _buildDescription(BuildContext context) {
//    String descText = widget.comboDetail.;
//    return Container(
//      padding: EdgeInsets.all(16.0),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Text("Description",
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 15,
//                  color: kTextColor)),
//          Html(data:descText),
//          SizedBox(
//            height: 8,
//          ),
//          // Center(
//          //   child: GestureDetector(
//          //     onTap: () {
//          //       _settingModalBottomSheet(
//          //           context, widget.productDetail.description);
//          //     },
//          //     child: Text(
//          //       "View More",
//          //       style: TextStyle(
//          //           fontWeight: FontWeight.bold,
//          //           color: Colors.blueGrey,
//          //           fontSize: 16),
//          //     ),
//          //   ),
//          // )
//        ],
//      ),
//    );
//  }

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
