import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecapp/bloc/banner_bloc.dart';
import 'package:ecapp/models/response/banner_response.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'discount-view.dart';

class DiscountCard extends StatefulWidget {
  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  bool isLoading = true;
  final _key = UniqueKey();

  // const DiscountCard({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        StreamBuilder<BannerResponse>(
          stream: bannerBloc.banners,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return CarouselSlider.builder(
                  itemCount: snapShot.data.banners.length,
                  options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    final item = snapShot.data.banners[itemIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "discountView",
                            arguments: DiscountInfo(
                                image: item.imageThumbnail,
                                imageUrl: item.imageLink,
                                caption: item.caption,
                                url: item.url));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(5.0),
                        width: double.infinity,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          imageUrl: item.imageLink,
//            imageUrl: product.imageThumbnail,
                          imageBuilder: (context, imageProvider) => Container(
//              width: 75,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placeholder.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return _buildShimmerWidget();
          },
        ),
      ],
    );
  }
}

Widget _buildShimmerWidget() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.black26,
      period: Duration(milliseconds: 1000),
      highlightColor: Colors.white70,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(height: 160, width: 300, color: Colors.black26),
              ],
            ),
//            SizedBox(width: 15),
          ],
        ),
      ),
    ),
  );
}
//  _navigateToDiscountView(BuildContext context) {
//     Banner banner = Banner();
//     imageUrl: banner.imageThumbnail,
//     imageUrl: product.imageThumbnail;

//     Navigator.pushNamed(context, "discountView", arguments: banner);
//   }
