import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/review_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/models/review.dart';
import 'package:flutter/material.dart';

class RatingsReviewsPage extends StatefulWidget {
  String slug;

  RatingsReviewsPage({Key key, this.slug}) {}

  @override
  _RatingsReviewsPageState createState() => _RatingsReviewsPageState();
}

class _RatingsReviewsPageState extends State<RatingsReviewsPage> {
  String slug;

  @override
  void initState() {
    super.initState();
    reviewBloc.getProductReview("false", widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Ratings & Reviews")),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<ReviewResponse>(
        stream: reviewBloc.review.stream,
        builder: (context, AsyncSnapshot<ReviewResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
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
    return Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return reviewItemWidget(
                  reviews[index],
                );
              }),
        ));
  }

  Widget reviewItemWidget(review) {
    final children = <Widget>[];
    for (int i = 0; i < review.imageThumbnail?.length ?? 0; i++) {
      children.add(Container(
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              image: NetworkImage(review.imageThumbnail[i]),
              height: 120,
            )),
      ));
    }
    return Container(
      padding: EdgeInsets.all(10),
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
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(tr(review.userName)),
                SizedBox(width: 10.0),
                Text(tr(review.reviewedDate)),
              ]),
              StarRating(rating: review.rating, size: 20),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(
              tr(review.headline),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Text(
              tr(review.message),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  child: Row(children: children))),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(tr('Flavour:')),
              Text(tr(widget.slug)),
            ],
          ),
        ],
      ),
    );
  }
}
