import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SideScrollCardLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black26,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.white70,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(8, (int index) {
            return Row(
              children: [
                Container(
                  height: 260,
                  width: 160,
                  color: Colors.black26,
                ),
                SizedBox(width: 10.0)
              ],
            );
          }),
        ));
  }
}
