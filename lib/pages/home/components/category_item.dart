import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function press;

  const CategoryItem({
    Key key,
    this.title,
    this.isActive = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
        label: Text(title),
        elevation: 6.0,
        padding: EdgeInsets.all(6.0)
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
//            if (isActive)
//              Container(
//                margin: EdgeInsets.symmetric(vertical: 5),
//                height: 3,
//                width: 22,
//                decoration: BoxDecoration(
//                  color: kPrimaryColor,
//                  borderRadius: BorderRadius.circular(10),
//                ),
//              ),
          ],
        ),
      ),
    );
  }
}
