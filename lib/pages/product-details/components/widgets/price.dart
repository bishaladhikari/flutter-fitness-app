import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/combo_detail.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProductPrice extends StatefulWidget {
  final ProductDetail productDetail;
  final ComboDetail comboDetail;

  const ProductPrice({Key key,this.comboDetail,this.productDetail}) : super(key: key);

  @override
  _ProductPriceState createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  ProductDetailBloc productDetailBloc;
  @override
  void initState() {
    productDetailBloc= ProductDetailBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//    StreamBuilder<ProductDetailResponse>(
//      stream: productDetailBloc.subject.stream,
//      builder: (context, snapshot) {
//        if(snapshot.hasData){
//          Attribute attribute = snapshot.data.productDetail.selectedAttribute;
//          return _buildProductPrice(attribute);
//        }
//        return Container();
//      }
//    );
    return widget.productDetail != null ? _buildProductPrice(widget.productDetail.selectedAttribute) : _buildComboPrice(widget.comboDetail);
  }

  Widget _buildProductPrice(Attribute attribute) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            attribute.discountPrice != null
                ? Text(
                    "\¥" + attribute.sellingPrice,
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
              attribute.discountPrice != null
                  ? "\¥" + attribute.discountPrice
                  : "\¥" + attribute.sellingPrice,
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

  Widget _buildComboPrice(ComboDetail comboDetail) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            comboDetail.price != null
                ? Text(
                    "\¥" + comboDetail.actualPrice.toString(),
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
              comboDetail.price != null
                  ? "\¥" + comboDetail.price.toString()
                  : "\¥" + comboDetail.actualPrice.toString(),
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
}
