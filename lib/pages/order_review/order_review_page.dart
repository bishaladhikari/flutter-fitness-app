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
  final OrderProductDetail orderProduct;

  OrderReviewPage({Key key, this.orderProduct}) : super(key: key);

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  OrderProductDetail orderProduct;
  double rating = 0.0;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController headingController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _obscureText = true;
  bool _validate = false;
  OrderProductDetailBloc orderProductDetailBloc;
  CustomerReviewBloc customerReviewBloc;

  @override
  void initState() {
    super.initState();
    orderProduct = widget.orderProduct;
    orderProductDetailBloc = OrderProductDetailBloc();
    customerReviewBloc = CustomerReviewBloc();
  }

  @override
  void dispose() {
    super.dispose();
    orderProductDetailBloc..drainStream();
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
        body: orderProduct.reviewed ? _loadFormData(context) : _buildForm(
            context));
  }

  _buildForm(BuildContext context) {
    return SingleChildScrollView(
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
                  contentPadding:
                  new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  contentPadding:
                  new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  "order_attribute_id": orderProduct.orderAttributeId,
                  "image": null
                };
                _validateReviewForm(context, params);
              },
              child: Container(
                height: 50.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
    );
  }

  _loadFormData(BuildContext context) {
    return StreamBuilder<CustomerReviewResponse>(
      stream:
      customerReviewBloc
          .getProductReviewById(orderProduct.reviewId)
          .stream,
      builder: (context, AsyncSnapshot<CustomerReviewResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  _validateReviewForm(context, params) async {
    // if (_formKey.currentState.validate()) {
    OrderProductDetailResponse response =
    await orderProductDetailBloc.addProductReview(params);
    // } else {
    //   setState(() => _validate = true);
    // }
  }

  Widget _buildLoadingWidget() {
    var width = MediaQuery
        .of(context)
        .size
        .width - 16;

    return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularProgressIndicator(),
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occurred: $error"),
          ],
        ));
  }

  Widget _buildHomeWidget(CustomerReviewResponse data) {
    CustomerReview customerReview = data.customerReview;
    return Center(
      child: Text("Form"),
    );
  }
}
