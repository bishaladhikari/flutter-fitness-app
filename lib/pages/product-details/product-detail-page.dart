import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/models/attribute.dart';

//import 'package:ecapp/models/attribute_image.dart' as Image;
import 'package:ecapp/models/attribute_image.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/variant.dart';
import 'package:ecapp/widgets/dotted_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';
import 'components/related_products_list.dart';
import 'components/same_seller_list.dart';

import 'components/detail_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final index;
  Variant selectedVariant;
  Attribute selectedAttribute;
  List<AttributeImage> images = [];

  ProductDetailPage({Key key, this.product, this.selectedVariant, this.index}) {
//    super(key: key);
    this.images.add(AttributeImage.fromJson(
        {"image_thumbnail": this.product.imageThumbnail}));
  }

//  ProductPage({this.product});
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();

  static _ProductDetailPageState of(BuildContext context) {
    final _ProductDetailPageState navigator = context
        .ancestorStateOfType(const TypeMatcher<_ProductDetailPageState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a ProductDetailPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double myscroll = 1;
  double appBarV = 0;
  bool isClicked = false;
  ProductDetailBloc productDetailBloc;
  String slug;
  AnimationController _animationController;
  Animation _opacityTween;

  setImages(value) {
    setState(() {
      widget.images = value;
    });
  }

//  set selectedAttribute(Attribute value) {
//    setState(() {
//      selectedAttribute = value;
//    });
//  } //  Product product;

//  get selectedAttribute => _selectedAttribute;

  _ProductDetailPageState();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _opacityTween = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    productDetailBloc = ProductDetailBloc();

    slug = widget.product.slug;
    productDetailBloc.getProductDetail(slug);
    productDetailBloc.getSameSellerProduct(slug);
    productDetailBloc.getRelatedProduct(slug);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
//    print("disposed productDetail");
    productDetailBloc..drainStream();
  }

  addToCart(context, params) async {
    AddToCartResponse response = await cartBloc.addToCart(params);
    if (response.error != null) {
      var snackbar = SnackBar(
        content: Text(response.error),
        backgroundColor: Colors.redAccent,
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      var snackbar = SnackBar(
        content: Row(
          children: [
            Text("Item added to cart"),
            Spacer(),
//            GestureDetector(onTap: () {}, child: Text("Go to cart",style: TextStyle(color: Colors.red),))
          ],
        ),
        backgroundColor: NPrimaryColor,
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: Colors.white,
//    ));
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          NotificationListener<ScrollUpdateNotification>(
            child: CustomScrollView(
//              mainAxisSize: MainAxisSize.max,
              slivers: [
                SliverAppBar(
                  flexibleSpace: Stack(
                    children: [
                      StreamBuilder<ProductDetailResponse>(
                          stream: productDetailBloc.subject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              ProductDetail productDetail =
                                  snapshot.data.productDetail;
                              return dottedSlider(
                                  productDetail.selectedAttribute.images);
                            }
                            return dottedSlider(widget.images);
                          }),
                      Container(
                        height: 80,
                        child: Row(
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: NPrimaryColor,
//                              size: 35.0,
                              ),
                              padding: EdgeInsets.all(8.0),
                              shape: CircleBorder(),
                            ),
                            Spacer(),
                            RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.favorite_border,
                                color: NPrimaryColor,
//                              size: 35.0,
                              ),
                              padding: EdgeInsets.all(8.0),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [ Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              StarRating(
                                  rating: widget.product.avgRating, size: 10),
                              SizedBox(
                                width: 8,
                              ),
                              Text("(3) reviews")
                            ],
                          ),
                        ),
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
                                return _buildLoadingWidget(context);
                              }
                              return _buildLoadingWidget(context);
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        _buildProducts(context),
//                    _buildSameSellerProducts(context),
                        _buildComments(context),
                      ],
                    )],
                  ),
                )
              ],
            ),
            onNotification: (notification) {
              //How many pixels scrolled from pervious frame
//          print(notification.scrollDelta);

              //List scroll position
//          print(notification.metrics.pixels);
//              setState(() {
//                myscroll = 100 - notification.metrics.pixels;
//                appBarV = (notification.metrics.pixels / 100);
//                myscroll = (myscroll / 100);
//                print(myscroll);
//              });
//              return true;
              if (notification.metrics.axis == Axis.vertical) {
                _animationController
                    .animateTo(notification.metrics.pixels / 350);
                return true;
              }
              return false;
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: _opacityTween.value,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(top: 15),
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: Alignment.bottomCenter,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {},
                      ),
                      Text(
                        widget.product.name,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
//        body: CustomScrollView(slivers: [
//    SliverAppBar(
//    title: Text("Details"),
//    actions: <Widget>[
//    IconButton(
//    icon: Icon(Icons.favorite_border),
//    color: NPrimaryColor,
//    splashRadius: 50,
//    splashColor: Colors.white,
//    onPressed: () {},
//    ),
//    ],
//    iconTheme: IconThemeData(
//    color: Colors.black, //change your color here
//    ),
//    backgroundColor: Colors.white,
//    expandedHeight: MediaQuery.of(context).size.height / 2.6,
//    floating: false,
//    pinned: true,
//    flexibleSpace: FlexibleSpaceBar(
////                centerTitle: true,
////                  title: Expanded(
////                    child: Text(
////                      "I have a very long name which is "+widget.product.name,
////                      style: TextStyle(
////                        color: Colors.black,
////                        fontSize: 14.0,
////                      ),
////                    ),
////                  ),
//    background: StreamBuilder<ProductDetailResponse>(
//    stream: productDetailBloc.subject.stream,
//    builder: (context, snapshot) {
//    if (snapshot.hasData) {
//    ProductDetail productDetail = snapshot.data.productDetail;
//    return dottedSlider(
//    productDetail.selectedAttribute.images);
//    }
//    return dottedSlider(widget.images);
//    }),
//    )),
//    SliverList(
//    delegate: SliverChildListDelegate([
//    Column(
//    mainAxisAlignment: MainAxisAlignment.start,
//    children: <Widget>[
//    Padding(
//    padding: const EdgeInsets.all(8.0),
//    child: Row(
//    mainAxisAlignment: MainAxisAlignment.start,
//    children: [
//    Text(
//    widget.product.name,
//    style: TextStyle(
//    fontSize: 24,
//    color: Colors.black,
//    fontWeight: FontWeight.bold),
//    ),
//    ],
//    ),
//    ),
//    SizedBox(height: 8),
//    Padding(
//    padding: const EdgeInsets.all(8.0),
//    child: Row(
//    children: [
//    StarRating(rating: widget.product.avgRating, size: 10),
//    SizedBox(
//    width: 8,
//    ),
//    Text("(3) reviews")
//    ],
//    ),
//    ),
//    StreamBuilder<ProductDetailResponse>(
//    stream: productDetailBloc.subject.stream,
//    builder: (context, snapshot) {
//    if (snapshot.hasData) {
//    if (snapshot.data.error != null &&
//    snapshot.data.error.length > 0) {
//    return _buildErrorWidget(snapshot.data.error);
//    }
//    return _buildDetailWidget(snapshot.data);
//    } else if (snapshot.hasError) {
//    return _buildErrorWidget(snapshot.error);
//    } else {
//    return _buildLoadingWidget(context);
//    }
//    return _buildLoadingWidget(context);
//    }),
//    SizedBox(
//    height: 10,
//    ),
//    _buildProducts(context),
//    _buildSameSellerProducts(context),
//    _buildComments(context),
//    ],
//    )
//    ]),
//    )
//    ]),
      bottomNavigationBar: StreamBuilder<ProductDetailResponse>(
          stream: productDetailBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var attribute_id =
                  snapshot.data.productDetail.selectedAttribute.id;
              return Container(
                color: Theme.of(context).backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 11,
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
                          IconButton(
                            icon: SvgPicture.asset("assets/icons/Cart_02.svg"),
                            color: Colors.black26,
                            onPressed: () {
                              Navigator.pushNamed(context, "cartPage");
                            },
                          ),
                          FlatButton(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.9,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 170, 192, 211),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.green,
//                        blurRadius: 4.0,
//                        spreadRadius: 2.0,
//                        offset: Offset(0.0, 0.0),
//                      )
//                    ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Text(
                                    "Add to cart",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              var params = {
                                "attribute_id": attribute_id,
                                "combo_id": null,
                                "quantity": 1
                              };
                              addToCart(context, params);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      FlatButton(
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
                          width: MediaQuery.of(context).size.width / 2.9,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: NPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.green,
//                        blurRadius: 4.0,
//                        spreadRadius: 2.0,
//                        offset: Offset(0.0, 0.0),
//                      )
//                    ],
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
              );
            }
            return Container(
              color: Colors.white70,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 25,
                      color: Colors.black26,
                    ),
                  )),
            );
          }),
    );
  }

  _buildDetailWidget(ProductDetailResponse data) {
    ProductDetail productDetail = data.productDetail;
//    final controller = AnimationController(
//      vsync: this,
//        duration: Duration(milliseconds: 500));
//    final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
//    controller.forward();
    return DetailWidget(
        productDetail: productDetail, productDetailBloc: productDetailBloc);
  }

  Widget _buildLoadingWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 16;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black26,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 25, width: width / 1.2, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width / 1.5, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width / 2, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
            Container(height: 100, width: width, color: Colors.black26),
            Container(height: 25, width: width, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width, color: Colors.black26),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
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

  Widget _productSlideImage(String imageUrl) {
    return Center(
      child: Hero(
        tag: widget.product.heroTag,
//            tag:product.imageThumbnail,
        child: CachedNetworkImage(
          placeholder: (context, url) => Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          imageUrl: imageUrl,
//            imageUrl: product.imageThumbnail,
          imageBuilder: (context, imageProvider) => Container(
//              width: 75,
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
          ),
          errorWidget: (context, url, error) => Center(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );

//      Hero(
//      tag:widget.product.heroTag,
//      child: Container(
//        height: 200,
//        width: double.infinity,
//        decoration: BoxDecoration(
//          image:
//              DecorationImage(image: CachedNetworkImage(imageUrl:imageUrl,placeholder: ,), fit: BoxFit.contain),
//        ),
//      ),
//    );
  }

  Widget dottedSlider(images) {
//    List<AttributeImage> images = images;
    final children = <Widget>[];
    for (int i = 0; i < images?.length ?? 0; i++) {
      if (images[i] == null) {
        children.add(Center(child: CircularProgressIndicator()));
      } else {
        children.add(_productSlideImage(images[i].imageThumbnail));
      }
    }
    return DottedSlider(
      maxHeight: 280,
      children: children,
      color: NPrimaryColor,
    );
  }

  _buildComments(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
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
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 16.0, color: Colors.blue),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "You may also like",
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
        RelatedProductsList(slug: slug),
        // buildTrending()
      ],
    );
  }

  _buildSameSellerProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
        SameSellerList(slug: slug),
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
