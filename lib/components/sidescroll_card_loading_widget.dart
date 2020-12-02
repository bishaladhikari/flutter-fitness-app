import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SideScrollCardLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 160, color: Colors.black26),
              SizedBox(width: 5),
              Container(height: 260, width: 10, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
