import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/variant.dart';
import 'package:ecapp/pages/home/components/related_products_list.dart';
import 'package:ecapp/pages/home/components/same_seller_list.dart';
import 'package:ecapp/widgets/dotted_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constants.dart';
import 'components/detail_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final product;
  Variant selectedVariant;

  ProductDetailPage({Key key, this.product, this.selectedVariant})
      : super(key: key);

//  ProductPage({this.product});
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isClicked = false;

//  Product product;

  _ProductDetailPageState();

  @override
  void initState() {
    super.initState();
    productDetailBloc.getProductDetail(widget.product.slug);
  }

  @override
  void dispose() {
    super.dispose();
    productDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme
            .of(context)
            .backgroundColor,
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height / 11,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    child: Divider(
                      color: Colors.black26,
                      height: 4,
                    ),
                    height: 24,
                  ),
                  Text(
                    "\$ 5.674",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "\$ 3.800",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                width: 6,
              ),
              RaisedButton(
                onPressed: () {
                  _alert(context);
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2.9,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: [
//                      BoxShadow(
////                        color: Colors.green,
//                        blurRadius: 15.0,
//                        spreadRadius: 7.0,
//                        offset: Offset(0.0, 0.0),
//                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.black26,
                    onPressed: () {},
                  ),
                ],
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery
                    .of(context)
                    .size
                    .height / 2.4,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
//                centerTitle: true,
                  title: Text(
                    widget.product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: dottedSlider(),
                  ),
                )),
          ];
        },
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<ProductDetailResponse>(
                    stream: productDetailBloc.subject.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.error != null &&
                            snapshot.data.error.length > 0) {
                          return _buildErrorWidget(snapshot.data.error);
                        }

                        return _buildDetailWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error);
                      } else {
                        return _buildLoadingWidget();
                      }
                    }),
                SizedBox(height: 10,),
                _buildProducts(context),
                _buildSameSellerProducts(context),
                _buildComments(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDetailWidget(ProductDetailResponse data) {
    ProductDetail productDetail = data.productDetail;
    if (widget.selectedVariant == null)
      widget.selectedVariant = productDetail.variants[0];
    return DetailWidget(productDetail);
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Shopping Cart",
      desc: "Your product has been added to cart.",
      buttons: [
        DialogButton(
          child: Text(
            "BACK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GO CART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => null,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  _productSlideImage(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image:
        DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.contain),
      ),
    );
  }

  dottedSlider() {
    return StreamBuilder<ProductDetailResponse>(
        stream: productDetailBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProductDetail productDetail = snapshot.data.productDetail;
            return DottedSlider(
              maxHeight: 200,
              children: <Widget>[
//                _productSlideImage(
//                    productDetail.attributes[0].images[0].imageThumbnail),
//                _productSlideImage(
//                    productDetail.attributes[0].images[0].imageThumbnail),
//                _productSlideImage(
//                    productDetail.attributes[0].images[0].imageThumbnail),
//                _productSlideImage(
//                    productDetail.attributes[0].images[0].imageThumbnail),
              ],
            );
          }
          return Container();
        });
  }

  _buildComments(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarRating(rating: 4, size: 20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "1250 Comments",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
              ),
              subtitle: Text(
                  "Cats are good pets, for they are clean and are not noisy."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "12 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.familiadejesusperu.org/images/avatar/john-doe-13.jpg"),
              ),
              subtitle: Text(
                  "There was no ice cream in the freezer, nor did they have money to go to the store."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "15 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1020903668240052225/_6uVaH4c.jpg"),
              ),
              subtitle: Text(
                  "I think I will buy the red car, or I will lease the blue one."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "25 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Related Products",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
         RelatedProductsList(),
        // buildTrending()
      ],
    );
  }

  _buildSameSellerProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "From same seller",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
         SameSellerList(),
        // buildTrending()
      ],
    );
  }


  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
//              TrendingItem(
//                product: Product(
//                    company: 'Apple',
//                    name: 'iPhone 7 plus (128GB)',
//                    icon: 'assets/iphone_7.png',
//                    rating: 4.5,
//                    remainingQuantity: 5,
//                    price: '\$2,000'),
//                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Apple',
//                    name: 'iPhone 11 (128GB)',
//                    icon: 'assets/phone1.jpeg',
//                    rating: 4.5,
//                    remainingQuantity: 5,
//                    price: '\$4,000'),
//                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'iPhone',
//                    name: 'iPhone 11 (64GB)',
//                    icon: 'assets/phone2.jpeg',
//                    rating: 4.5,
//                    price: '\$3,890'),
//                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Xiaomi',
//                    name: 'Xiaomi Redmi Note8',
//                    icon: 'assets/mi1.png',
//                    rating: 3.5,
//                    price: '\$2,890'),
//                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Apple',
//                    name: 'iPhone 11 (128GB)',
//                    icon: 'assets/phone1.jpeg',
//                    rating: 4.5,
//                    remainingQuantity: 5,
//                    price: '\$4,000'),
//                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'iPhone',
//                    name: 'iPhone 11 (64GB)',
//                    icon: 'assets/phone2.jpeg',
//                    rating: 4.5,
//                    price: '\$3,890'),
//                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Xiaomi',
//                    name: 'Xiaomi Redmi Note8',
//                    icon: 'assets/mi1.png',
//                    rating: 3.5,
//                    price: '\$2,890'),
//                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Apple',
//                    name: 'iPhone 11 (128GB)',
//                    icon: 'assets/phone1.jpeg',
//                    rating: 4.5,
//                    remainingQuantity: 5,
//                    price: '\$4,000'),
//                gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'iPhone',
//                    name: 'iPhone 11 (64GB)',
//                    icon: 'assets/phone2.jpeg',
//                    rating: 4.5,
//                    price: '\$3,890'),
//                gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
//              ),
//              TrendingItem(
//                product: Product(
//                    company: 'Xiaomi',
//                    name: 'Xiaomi Redmi Note8',
//                    icon: 'assets/mi1.png',
//                    rating: 3.5,
//                    price: '\$2,890'),
//                gradientColors: [Color(0XFFf28767), Colors.orange[400]],
//              ),
            ],
          ),
        )
      ],
    );
  }
}

