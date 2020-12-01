import 'package:flutter/material.dart';

import 'no_internet_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  String error;

  @override
  Widget build(BuildContext context) {
    if (error == "No internet connection") return NoInternetWidget();
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  CustomErrorWidget(this.error);
}
