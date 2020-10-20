import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DottedBorder(
        // padding: EdgeInsets.all(20.0),
        color: Colors.black26,
        strokeWidth: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'addressFormPage');
          },
          child: Container(
            // width: 310.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: const Color(0XFFB3E5FC),
            ),
            child: Text(
              " + Add address",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
            alignment: Alignment(
              0.0,
              0.0,
            ),
          ),
        ),
      ),
    );
  }
}
