import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProductPrice extends StatefulWidget {
  final product;
  final combo;

  const ProductPrice({Key key, this.product, this.combo}) : super(key: key);

  @override
  _ProductPriceState createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  @override
  Widget build(BuildContext context) {
    return widget.product != null ? _buildProductPrice() : _buildComboPrice();
  }

  Widget _buildProductPrice() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.product.discountPrice != null
                ? Text(
                    "\¥" + widget.product.sellingPrice,
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
                  ? "\¥" + widget.product.discountPrice
                  : "\¥" + widget.product.sellingPrice,
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

  Widget _buildComboPrice() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.combo.price != null
                ? Text(
                    "\¥" + widget.combo.actualPrice.toString(),
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
              widget.combo.price != null
                  ? "\¥" + widget.combo.price.toString()
                  : "\¥" + widget.combo.actualPrice.toString(),
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
