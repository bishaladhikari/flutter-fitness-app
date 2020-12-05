import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/main_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductItem extends StatelessWidget {
  final Product product;

//  final List<Color> gradientColors;
  final width;

  ProductItem({this.product, this.width = 162.0});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = width;
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 295,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Color(0xFFB0CCE1).withOpacity(0.32),
                ),
              ],
            ),
            width: width,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _productImage(),
                      SizedBox(height: 8),
                      _productDetails()
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
//            margin: EdgeInsets.only(horizontal: 1, ve: 0),
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(tr('Add To Cart'), style: TextStyle(fontSize: 14)),
                        onPressed: () => {},
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        if (await mainBloc.isInternetAvailable())
          Navigator.pushNamed(context, "productDetailPage", arguments: product);
        else
          Navigator.pushNamed(context, "noInternetPage");
      },
    );
  }

  _productImage() {
    return Hero(
      tag: product.heroTag,
//            tag:product.imageThumbnail,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            imageUrl: product.imageThumbnail,
//            imageUrl: product.imageThumbnail,
            imageBuilder: (context, imageProvider) => Container(
              height: 130,
//              width: 140,
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              )),
            ),
            errorWidget: (context, url, error) => Center(
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDetails() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: kTextColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            product.category.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 11, color: Color(0XFFb1bdef)),
          ),
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text(
                  product.discountPrice != null
                      ? "\¥" + product.discountPrice
                      : "\¥" + product.sellingPrice,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: NPrimaryColor)),
              SizedBox(width: 6),
              product.discountPrice != null
                  ? Text(
                      "\¥" + product.sellingPrice,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough),
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 8),
          StarRating(rating: product.avgRating, size: 10),
        ],
      ),
    );
  }
}
