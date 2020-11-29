import 'package:ecapp/bloc/customer_review_bloc.dart';
import 'package:ecapp/bloc/order_product_detail_bloc.dart';
import 'package:ecapp/components/dialogs.dart';
import 'package:ecapp/models/customer_review.dart';
import 'package:ecapp/models/order_product_detail.dart';
import 'package:ecapp/models/response/order_product_item_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  FToast fToast;
  OrderProductDetail orderProductItem;
  double rating = 0.0;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _validate = false;

  CustomerReviewBloc customerReviewBloc;

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(context);

    orderProductItem = widget.orderProductItem;
    if (widget.customerReview != null) {
//      rating = int.parse(widget.customerReview.rating) ?? 0;
      rating = widget.customerReview.rating;
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
    headingController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Place Review"),
          backgroundColor: Colors.white,
          actions: [
            widget.customerReview != null
                ? Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        OrderProductItemResponse response;
                        final action = await Dialogs.yesAbortDialog(
                            context,
                            'Are you sure want to delete?',
                            'You won\'t be able to revert this!');
                        if (action == DialogAction.yes) {
                          var params = {
                            "order_attribute_id":
                                orderProductItem.orderAttributeId,
                            "id": orderProductItem.reviewId
                          };

                          response = await orderProductDetailBloc
                              .deleteProductReview(params);
                          if (response.error == null) {
                            Navigator.pop(context);
                            _showToast("Review Deleted", "green");
                          } else {
                            _showToast("Error!. Please Try Again.", "red");
                          }
                        }
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  )
                : Text("")
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text("Overall Rating: " + rating.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {
                          setState(() {
                            rating = v;
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
                  Form(
                      key: _formKey,
                      autovalidate: _validate,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add a headline ",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.black)),
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
                                RequiredValidator(
                                    errorText: "Heading is required"),
                              ]),
                            ),
                            SizedBox(height: 10),
                            Text("Write your review ",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.black)),
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
                                RequiredValidator(
                                    errorText: "Message is required"),
                              ]),
                            ),
                            SizedBox(height: 20),
                          ])),
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
          ),
        ));
  }

  _validateReviewForm(context, params) async {
    OrderProductItemResponse response;

    if (rating == 0)
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please provide rating."),
        backgroundColor: Colors.redAccent,
      ));

    if (_formKey.currentState.validate()) {
      if (widget.customerReview != null) {
        params["id"] = widget.customerReview.id;
        response = await orderProductDetailBloc.updateProductReview(params);
      } else
        response = await orderProductDetailBloc.addProductReview(params);

      if (response.error == null) {
        Navigator.pop(context);
        _showToast("Review Submitted", "green");
      } else
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        ));
    }
  }

  _showToast(msg, color) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color == "green" ? Colors.green : Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
