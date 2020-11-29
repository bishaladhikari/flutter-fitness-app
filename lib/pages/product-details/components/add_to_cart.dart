import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/combo_detail_bloc.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/combo_detail.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/pages/product-details/components/widgets/price.dart';
import 'package:ecapp/pages/product-details/components/widgets/variants.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  Function addToCart;
  ProductDetailBloc productDetailBloc;
  ProductDetail productDetail;
  ComboDetailBloc comboDetailBloc;
  ComboDetail comboDetail;

  AddToCart(
      {this.addToCart,
      this.productDetailBloc,
      this.productDetail,
      this.comboDetailBloc,
      this.comboDetail});

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.productDetail != null
        ? _buildProductCart()
        : _buildComboCart();
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        Text(
          "Quantity: ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
//        Spacer(),
        IconButton(
          icon: Icon(
            Icons.remove,
            color: Colors.black87.withOpacity(0.5),
            size: 20,
          ),
          splashRadius: 5.0,
          onPressed: () {
            if (quantity > 1)
              setState(() {
                quantity--;
              });
          },
        ),
        Container(
//                                height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kForeGroundColor)),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Center(
            child: Text(
              quantity.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black87.withOpacity(0.5),
            size: 20,
          ),
          splashRadius: 5.0,
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildProductCart() {
    return StreamBuilder<ProductDetailResponse>(
        stream: widget.productDetailBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            ProductDetail productDetail = snapshot.data.productDetail;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productDetail.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                  ProductPrice(productDetail: productDetail),
                  Variants(
                      productDetail: productDetail,
                      productDetailBloc: widget.productDetailBloc),
                  _buildQuantity(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: NPrimaryColor,
                      onPressed: () async {
                        var params = {
                          "attribute_id":
                          productDetail?.selectedAttribute?.id,
                          "combo_id": null,
                          "quantity": quantity
                        };
                        widget.addToCart(context, params,false);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Add to cart".tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );

          }
          else
            return Container();
        });
  }

  Widget _buildComboCart() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.comboDetail.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          ProductPrice(comboDetail: widget.comboDetail),
          // Variants(
          //     productDetail: productDetail,
          //     productDetailBloc: widget.productDetailBloc),
          _buildQuantity(),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              color: NPrimaryColor,
              onPressed: () async {
                var params = {
                  "attribute_id": null,
                  "combo_id": widget.comboDetail.id,
                  "quantity": quantity
                };
                widget.addToCart(context, params);
              },
              child: Text(
                "Add to cart".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
