import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecapp/bloc/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';
import 'package:shimmer/shimmer.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bannerBloc.getBanners();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: bannerBloc.banners,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return CarouselSlider.builder(
                    itemCount: snapShot.data.data.length,
                    options: CarouselOptions(
                        height: 166.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn),
                    itemBuilder: (BuildContext context, int itemIndex) {
                      final item = snapShot.data.data[itemIndex];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                              item.imageThumbnail,
                            ))),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF961F).withOpacity(0.7),
                                kPrimaryColor.withOpacity(0.7),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SvgPicture.asset(
                                      "assets/icons/macdonalds.svg"),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: item.caption.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        // TextSpan(
                                        //   text: "30% \n",
                                        //   style: TextStyle(
                                        //     fontSize: 43,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        TextSpan(
                                          text:
                                              "at MacDonald's on your first order & Instant cashback",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}

Widget _buildShimmerWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Shimmer.fromColors(
      baseColor: Colors.black26,
      period: Duration(milliseconds: 1000),
      highlightColor: Colors.white70,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(height: 120, width: 280, color: Colors.black26),
              ],
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    ),
  );
}
