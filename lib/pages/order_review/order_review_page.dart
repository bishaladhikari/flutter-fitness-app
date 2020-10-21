import 'package:ecapp/bloc/customer_review_bloc.dart';
import 'package:ecapp/bloc/order_product_detail_bloc.dart';
import 'package:ecapp/models/customer_review.dart';
import 'package:ecapp/models/order_product_detail.dart';
import 'package:ecapp/models/response/customer_review_response.dart';
import 'package:ecapp/models/response/order_product_detail_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';

class OrderReviewPage extends StatefulWidget {
  final OrderProductDetail orderProductItem;
  final CustomerReview customerReview;

  OrderReviewPage({Key key, this.orderProductItem})
      : customerReview = orderProductItem.customerReview,
        super(key: key);

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  OrderProductDetail orderProductItem;
  int rating = 0;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _obscureText = true;
  bool _validate = false;
  CustomerReviewBloc customerReviewBloc;

  @override
  void initState() {
    super.initState();
    print(widget.customerReview);
    orderProductItem = widget.orderProductItem;
    if (widget.customerReview != null) {
      rating = int.parse(widget.customerReview.rating) ?? 0;
      headingController = TextEditingController(
          text: widget.customerReview.headline == null
              ? ""
              : widget.customerReview.headline);
      messageController = TextEditingController(
          text: widget.customerReview.message == null
              ? ""
              : widget.customerReview.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // orderProductDetailBloc..drainStream();
    headingController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Place Review"),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Overall Rating: " + rating.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Container(
                  alignment: Alignment.center,
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {
                        setState(() {
                          rating = v.toInt();
                        });
                      },
                      starCount: 5,
                      rating: rating.toDouble(),
                      size: 40.0,
                      isReadOnly: false,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                      spacing: 0.0),
                ),
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    var params = {
                      "rating": rating,
                      "headline": "${headingController.text}",
                      "message": "${messageController.text}",
                      "order_attribute_id": orderProductItem.orderAttributeId,
                      "image": null
                    };
                    _validateReviewForm(context, params);
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: NPrimaryColor,
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Center(
                        child: Text(
                      "Submit Review",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  _validateReviewForm(context, params) async {
    OrderProductDetailResponse response;
    if (widget.customerReview != null) {
      params["id"] = widget.customerReview.id;
      response = await orderProductDetailBloc.updateProductReview(params);
    } else
      response = await orderProductDetailBloc.addProductReview(params);

    // if (response.error == null)
    Navigator.pop(context);
    // else
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text(response.error),
    //     backgroundColor: Colors.redAccent,
    //   ));
  }
}
