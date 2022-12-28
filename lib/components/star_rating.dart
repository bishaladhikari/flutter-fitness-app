import 'package:fitnessive/constants.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  StarRating({this.rating, this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: new List.generate(5, (index) => _buildStar(index, rating)));
  }

  _buildStar(int index, double rating) {
    IconData icon;
    Color color;
    if (index >= rating) {
      icon = Icons.star_border;
      color = kPrimaryColor;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = kPrimaryColor;
    } else {
      icon = Icons.star;
      color = kPrimaryColor;
    }
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
