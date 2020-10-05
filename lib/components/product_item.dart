import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/pages/product-details/product-detail-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';

class ProductItem extends StatelessWidget {
  final Product product;
//  final List<Color> gradientColors;
  final width;

  ProductItem({this.product, this.width = 150.0});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = width;

    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
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
                    SizedBox(height: 10),
                    _productDetails()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
            ),
          ),
        );
      },
    );
  }

  _productImage() {
    return Stack(
      children: <Widget>[
        Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Container(
                height: 100,
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
//              width: 75,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
            ),
            errorWidget: (context, url, error) => Center(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
//        Positioned(
//          top:0.0,
//          right: 0.0,
//          child: new IconButton(
//            color: Colors.white,
//                icon:   Icon(Ionicons.getIconData("ios-heart"), color: Colors.white),
//                onPressed: () {}),
//        ),
//        Center(
//          child: Container(
//            width: 75,
//            height: 75,
//            decoration: BoxDecoration(
//              image: DecorationImage(
////                  image: NetworkImage(product.imageThumbnail), fit: BoxFit.contain),
//                  image: CachedNetworkImlage(imageUr:"http://ecsite.eeeinnovation.com/storage/uploads/products/thumbnails/pro16007825145f6a00b22f9a53.png"), fit: BoxFit.contain),
//            ),
//          ),
//        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: kTextColor),
        ),
        SizedBox(height: 8,),
        Text(
          product.category.name,
          style: TextStyle(fontSize: 11, color: Color(0XFFb1bdef)),
        ),
        SizedBox(height: 10),
//        Row(
//          children: <Widget>[
//            Text(
//                "\$" + product.discountPrice != null
//                    ? product.discountPrice
//                    : product.sellingPrice,
//                style: TextStyle(
//                    fontSize: 15,
//                    fontWeight: FontWeight.bold,
//                    color: NPrimaryColor)),
//            SizedBox(width: 8),
//            product.discountPrice != null
//                ? Text(
//                    "\$" + product.sellingPrice,
//                    style: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 10,
//                        decoration: TextDecoration.lineThrough),
//                  )
//                : Container()
//          ],
//        ),
        SizedBox(height: 10),
        StarRating(rating: product.avgRating, size: 10),
      ],
    );
  }
}
