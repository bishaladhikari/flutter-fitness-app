import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSkeleton extends StatefulWidget {
  @override
  _ProductSkeletonState createState() => _ProductSkeletonState();
}

class _ProductSkeletonState extends State<ProductSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
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
      width: 160,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 160, width: 150, color: Colors.grey),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 150, height: 8, color: Colors.grey),
                SizedBox(height: 6),
                Container(width: 90, height: 8, color: Colors.grey),
                SizedBox(height: 6),
                Container(width: 150, height: 8, color: Colors.grey),
                SizedBox(height: 6),
                Container(width: 90, height: 8, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
