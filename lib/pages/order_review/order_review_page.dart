import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';

class OrderReviewPage extends StatefulWidget {
  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  double rating = 0.0;
  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Review"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Overall Rating: " + rating.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  isReadOnly: false,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                  spacing: 0.0),
              SizedBox(height: 10),
              Text("Add a headline ",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              SizedBox(height: 5),
              TextFormField(
                controller: headingController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Headline"),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Heading is required"),
                ]),
              ),
              SizedBox(height: 10),
              Text("Write your review ",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              SizedBox(height: 5),
              TextFormField(
                controller: messageController,
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Color(0xFF9b9b9b),
                minLines: 5,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Message"),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Heading is required"),
                ]),
              ),
              RaisedButton(
                elevation: 5,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text("Submit Review"),
                color: NPrimaryColor,
                textColor: Colors.white,
                splashColor: NPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
