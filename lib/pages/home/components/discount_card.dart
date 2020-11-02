import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecapp/bloc/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bannerBloc.getBanners();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder(
          stream: bannerBloc.banners,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return CarouselSlider.builder(
                  itemCount: snapShot.data.data.length,
                  options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    final item = snapShot.data.data[itemIndex];
                    return Container(
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
                        imageUrl: item.imageThumbnail,
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

                      // child: Image.network(
                      //   'https://i.ibb.co/mbWtWMs/beyond-meat-mcdonalds.png',
                      //   loadingBuilder: (BuildContext context, Widget child,
                      //       ImageChunkEvent loadingProgress) {
                      //     if (loadingProgress == null) return child;
                      //     return Center(
                      //       child: CircularProgressIndicator(
                      //         value: loadingProgress.expectedTotalBytes != null
                      //             ? loadingProgress.cumulativeBytesLoaded /
                      //                 loadingProgress.expectedTotalBytes
                      //             : null,
                      //       ),
                      //     );
                      //   },
                      // ),
                    );
                  });

              //       },
              //     );
              //   }).toList(),
              // );
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
