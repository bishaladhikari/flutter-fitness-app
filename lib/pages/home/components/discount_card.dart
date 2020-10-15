import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';
import 'package:shimmer/shimmer.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            height: 166,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              
            ),
             child: Image.network(
        'https://i.ibb.co/mbWtWMs/beyond-meat-mcdonalds.png',
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
            // child: DecoratedBox(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     gradient: LinearGradient(
            //       colors: [
            //         Color(0xFFFF961F).withOpacity(0.7),
            //         kPrimaryColor.withOpacity(0.7),
            //       ],
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Row(
            //       children: <Widget>[
            //         Expanded(
            //           child: SvgPicture.asset("assets/icons/macdonalds.svg"),
            //         ),
            //         Expanded(
            //           child: RichText(
            //             text: TextSpan(
            //               style: TextStyle(color: Colors.white),
            //               children: [
            //                 TextSpan(
            //                   text: "Get Discount of \n",
            //                   style: TextStyle(fontSize: 16),
            //                 ),
            //                 TextSpan(
            //                   text: "30% \n",
            //                   style: TextStyle(
            //                     fontSize: 43,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 TextSpan(
            //                   text:
            //                       "at MacDonald's on your first order & Instant cashback",
            //                   style: TextStyle(fontSize: 10),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
