import 'package:flutter/material.dart';

import '../../../../constants.dart';
class ProductPrice extends StatefulWidget {
  final product;

  const ProductPrice({Key key, this.product}) : super(key: key);
  @override
  _ProductPriceState createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.product.discountPrice != null
                ? Text(
              "\$" + widget.product.sellingPrice,
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
              widget.product.discountPrice != null
                  ? "\$" + widget.product.discountPrice
                  : "\$" + widget.product.sellingPrice,
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
