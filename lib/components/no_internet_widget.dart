import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/icons/no-connection.png",
              ),
            ),
            Text(
              tr("Oops"),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(tr("Something went wrong.")),
            Text(tr("Checkout your connection and try again.")),
//        GestureDetector(
//            onTap: () {
//              cartBloc.getCart();
//            },
//            child: Text(
//              tr("Retry"),
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Colors.blueAccent,
//                  fontSize: 16),
//            ))
          ],
        ),
      ),
    );
  }
}