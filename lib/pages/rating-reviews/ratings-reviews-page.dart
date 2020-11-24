import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/review_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/meta.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/models/review.dart';
import 'package:flutter/material.dart';

class RatingsReviewsPage extends StatefulWidget {
  ProductDetail productDetail;

  RatingsReviewsPage({Key key, this.productDetail}) {}

  @override
  _RatingsReviewsPageState createState() => _RatingsReviewsPageState();
}

class _RatingsReviewsPageState extends State<RatingsReviewsPage> {
  ReviewBloc reviewBloc;
  String slug;
  int page = 1;

  ScrollController _scrollController;

  @override
  void initState() {
    reviewBloc = ReviewBloc();
    getReviewsOfProduct();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      var triggerFetchMoreSize = 0.8 * maxScrollExtent;
      if (currentPosition >= triggerFetchMoreSize) {
        Meta meta = reviewBloc.subject.value.meta;
        if (page < meta.lastPage) {
          page++;
          getReviewsOfProduct();
        }
      }
    });

    super.didChangeDependencies();
  }

  getReviewsOfProduct() {
    reviewBloc.getProductReview("false", widget.productDetail.slug, page);
  }

  @override
  void dispose() {
    reviewBloc..drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tr("Ratings & Reviews")),
          backgroundColor: Colors.white,
        ),
        body: body());
  }

  Widget body() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildReviews(context),
          StreamBuilder<ReviewResponse>(
            stream: reviewBloc.subject.stream,
            builder: (context, AsyncSnapshot<ReviewResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildReviewsListWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }

  _buildReviews(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Ratings",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(children: <Widget>[
                      Row(
                        children: [
                          Text(
                            widget.productDetail.avgRating.toString() + "/5",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 40,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          StarRating(
                              rating: widget.productDetail.avgRating, size: 15),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.productDetail.reviewCount.toString() +
                                " Customer Ratings",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ])),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black12,
                    thickness: 1,
                    // height: 4,
                  ),
                  height: 100,
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StarRating(rating: 5, size: 15),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetail.fiveStarCount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StarRating(rating: 5, size: 15),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetail.fourStarCount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              StarRating(rating: 4, size: 15),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetail.threeStarCount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              StarRating(rating: 2, size: 15),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetail.twoStarCount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              StarRating(rating: 1, size: 15),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetail.oneStarCount.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildReviewsListWidget(ReviewResponse data) {
    List<Review> reviews = data.reviews;
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: reviews.map((Review review) {
          final children = <Widget>[];
          for (int i = 0; i < review.imageThumbnail?.length ?? 0; i++) {
            children.add(Container(
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image(
                    image: NetworkImage(review.imageThumbnail[i]),
                    height: 60,
                  )),
            ));
          }
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(review.customerImage),
            ),
            title: Column(
              children: [
                Row(
                  children: [Text(review.userName)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StarRating(rating: review.rating, size: 15),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      review.reviewedDate,
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.headline),
                Text(review.message),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(child: Row(children: children))),
              ],
            ),
          );
        }).toList());
  }

// Widget _buildReviewItemWidget(review) {
//   return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: reviews.map((Review review) {
//         final children = <Widget>[];
//         for (int i = 0; i < review.imageThumbnail?.length ?? 0; i++) {
//           children.add(Container(
//             child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Image(
//                   image: NetworkImage(review.imageThumbnail[i]),
//                   height: 60,
//                 )),
//           ));
//         }
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(review.customerImage),
//           ),
//           title: Column(
//             children: [
//               Row(
//                 children: [Text(review.userName)],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   StarRating(rating: review.rating, size: 15),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   Text(
//                     review.reviewedDate,
//                     style: TextStyle(fontSize: 10, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(review.headline),
//               Text(review.message),
//               SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Container(child: Row(children: children))),
//             ],
//           ),
//         );
//       }).toList());
//
//   final children = <Widget>[];
//   for (int i = 0; i < review.imageThumbnail?.length ?? 0; i++) {
//     children.add(Container(
//       child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Image(
//             image: NetworkImage(review.imageThumbnail[i]),
//             height: 120,
//           )),
//     ));
//   }
//   return Container(
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//           offset: Offset(0, 4),
//           blurRadius: 20,
//           color: Color(0xFFB0CCE1).withOpacity(0.32),
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(children: [
//               Text(tr(review.userName)),
//               SizedBox(width: 10.0),
//               Text(tr(review.reviewedDate)),
//             ]),
//             StarRating(rating: review.rating, size: 20),
//           ],
//         ),
//         Container(
//           alignment: Alignment.topLeft,
//           margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//           child: Text(
//             tr(review.headline),
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//         Container(
//           alignment: Alignment.topLeft,
//           margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
//           child: Text(
//             tr(review.message),
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: children))),
//           ],
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Text(tr('Flavour:')),
//             Text(tr(widget.productDetail.slug)),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
