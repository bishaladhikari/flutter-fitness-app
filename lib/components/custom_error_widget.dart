import 'package:flutter/material.dart';

import 'no_internet_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  String error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (error == "No internet connection")
            ? NoInternetWidget()
            : Text("Error occurred: $error"),
      ],
    ));
  }

  CustomErrorWidget(this.error);
}
