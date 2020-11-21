import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RatingsReviewsPage extends StatefulWidget {
  @override
  _RatingsReviewsPageState createState() => _RatingsReviewsPageState();
}

class _RatingsReviewsPageState extends State<RatingsReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Ratings & Reviews")),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text("I am wish list page"),
      ),
    );
  }
}
