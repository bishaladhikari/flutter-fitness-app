import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnessive/bloc/auth_bloc.dart';
import 'package:fitnessive/bloc/main_bloc.dart';
import 'package:fitnessive/constants.dart';
import 'package:fitnessive/models/combo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComboProductItem extends StatelessWidget {
  final Combo combo;

//  final List<Color> gradientColors;
  final width;

  ComboProductItem({this.combo, this.width = 160.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
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
//            height: 205,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Spacer(),
//                        Icon(
//                          Ionicons.getIconData("ios-heart-empty"),
//                          color: Colors.black54,
//                        )
//                      ],
//                    ),
                  _productImage(),
                  SizedBox(height: 8),
                  _productDetails()
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
//        productDetailBloc..drainStream();
        if(await mainBloc.isInternetAvailable())
        Navigator.pushNamed(context, "comboDetailPage", arguments: combo);
        else
        Navigator.pushNamed(context, "noInternetPage");
      },
    );
  }

  _productImage() {
    return Hero(
      tag: combo.heroTag,
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
            imageUrl: combo.imageThumbnail,
//            imageUrl: product.imageThumbnail,
            imageBuilder: (context, imageProvider) => Container(
//              width: MediaQuery.of(context).size.width,
//              width: 300,
              height: 130,
              width: 150,
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
        children: <Widget>[
          Text(
            combo.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: kTextColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            combo.attributesCount.toString() + " items",
            style: TextStyle(fontSize: 11, color: Color(0XFFb1bdef)),
          ),
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text(
                  combo.price != null
                      ? "\??" + combo.price.toString()
                      : "\??" + combo.actualPrice.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: NPrimaryColor)),
              SizedBox(width: 6),
              combo.actualPrice.toString() != null
                  ? Text(
                      "\??" + combo.actualPrice.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough),
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 10),
          // StarRating(rating: product.avgRating, size: 10),
        ],
      ),
    );
  }
}
