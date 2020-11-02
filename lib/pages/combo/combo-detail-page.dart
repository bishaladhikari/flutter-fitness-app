import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/combo_detail_bloc.dart';
import 'package:ecapp/bloc/review_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/combo_detail.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/combo_detail_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/models/review.dart';
import 'package:ecapp/pages/product-details/components/add_to_cart.dart';
import 'package:ecapp/pages/product-details/components/related_products_list.dart';
import 'package:ecapp/pages/product-details/components/same_seller_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import 'components/detail_widget.dart';

class ComboDetailPage extends StatefulWidget {
  final Combo combo;

  ComboDetailPage({Key key, this.combo}) {
//    super(key: key);
  }

  @override
  _ComboDetailPageState createState() => _ComboDetailPageState();

  static _ComboDetailPageState of(BuildContext context) {
    final _ComboDetailPageState navigator =
        context.ancestorStateOfType(const TypeMatcher<_ComboDetailPageState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError('Operation requested with a context that does '
            'not include a ComboDetailPage.');
      }
      return true;
    }());

    return navigator;
  }
}

class _ComboDetailPageState extends State<ComboDetailPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double myscroll = 1;
  double appBarV = 0;
  bool isClicked = false;
  ComboDetailBloc comboDetailBloc;
  String slug;
  AnimationController _animationController;
  Animation _opacityTween;
  ReviewBloc reviewBloc = ReviewBloc();

  _ComboDetailPageState();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _opacityTween = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    comboDetailBloc = ComboDetailBloc();

    slug = widget.combo.slug;
    comboDetailBloc.getComboDetail(slug);
    // productDetailBloc.getSameSellerProduct(slug);
    // productDetailBloc.getRelatedProduct(slug);
    reviewBloc.getProductReview("false", slug);
  }

  @override
  void dispose() {
    super.dispose();
    comboDetailBloc..drainStream();
    reviewBloc..drainStream();
  }

  addToCart(context, params) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
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
  }

  _addToWishlist(context) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      AddToWishlistResponse response = await comboDetailBloc.addToWishlist();
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
              Text("Successfully Updated"),
              Spacer(),
            ],
          ),
          backgroundColor: NPrimaryColor,
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    }
  }

  _removeFromWishlist(context) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      RemoveFromWishlistResponse response =
          await comboDetailBloc.deleteFromWishlist();
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
              Text("Successfully Updated"),
              Spacer(),
            ],
          ),
          backgroundColor: NPrimaryColor,
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          NotificationListener<ScrollUpdateNotification>(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  floating: false,
                  expandedHeight: 300,
                  title: AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget child) {
                        return Opacity(
                            opacity: _opacityTween.value,
                            child: Text(widget.combo.title));
                      }),
//                  leading: Container(),
//                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.combo.heroTag,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/placeholder.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        imageUrl: widget.combo.imageThumbnail,
//            imageUrl: product.imageThumbnail,
                        imageBuilder: (context, imageProvider) => Container(
//              width: 75,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/placeholder.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.combo.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       StarRating(
                          //           rating: widget.combo.avgRating, size: 10),
                          //       SizedBox(
                          //         width: 8,
                          //       ),
                          //       // Text("(3) reviews"),
                          //       Text("(" +
                          //           widget.product.reviewCount.toString() +
                          //           ")" +
                          //           " reviews")
                          //     ],
                          //   ),
                          // ),
                          StreamBuilder<ComboDetailResponse>(
                              stream: comboDetailBloc.subject.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.error != null &&
                                      snapshot.data.error.length > 0) {
                                    return _buildErrorWidget(
                                        snapshot.data.error);
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
                          _buildSameSellerProducts(context),
                          _buildComments(context),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.vertical) {
                print("current position" +
                    notification.metrics.pixels.toString());
                _animationController
                    .animateTo(notification.metrics.pixels / 400);
                return true;
              }
              return false;
            },
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<ComboDetailResponse>(
          stream: comboDetailBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var comboDetail = snapshot.data.comboDetail;
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
                          Stack(children: [
                            StreamBuilder<CartResponse>(
                                stream: cartBloc.subject.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return Positioned(
                                      right: 4,
                                      top: 2,
                                      child: new Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 14,
                                          minHeight: 14,
                                        ),
                                        child: Text(
                                          snapshot.data.totalItems.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  else
                                    return Container(
                                      height: 14,
                                    );
                                }),
                            IconButton(
                              icon:
                              SvgPicture.asset("assets/icons/Cart_02.svg"),
                              color: Colors.black26,
                              onPressed: () {
                                cartBloc.getCart();
                                Navigator.pushNamed(context, "cartPage");
                              },
                            ),
                          ]),
                          FlatButton(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.9,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 170, 192, 211),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
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
                              showMaterialModalBottomSheet(
                                  expand: false,
                                  bounce: true,
                                  context: context,
                                  builder: (context, scrollController) {
                                    return AddToCart(
                                        addToCart: addToCart,
                                        comboDetail: comboDetail,
                                        comboDetailBloc: comboDetailBloc);
                                  });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "checkoutPage");
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
//            return Container();
            return Container(
              color: Colors.white70,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                  )),
            );
          }),
    );
  }

  _buildDetailWidget(ComboDetailResponse data) {
    ComboDetail comboDetail = data.comboDetail;
//    final controller = AnimationController(
//      vsync: this,
//        duration: Duration(milliseconds: 500));
//    final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
//    controller.forward();
    return DetailWidget(
        comboDetail: comboDetail, comboDetailBloc: comboDetailBloc);
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
            Container(height: 25, width: width / 1.6, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width / 1.8, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width / 2, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
            Container(height: 60, width: width, color: Colors.black12),
            Container(height: 25, width: width, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
            Container(height: 25, width: width, color: Colors.black12),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
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
                  "Reviews",
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     StarRating(rating: widget.product.avgRating, size: 20),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     Text(
            //       widget.product.reviewCount.toString() + " Reviews",
            //       style: TextStyle(color: Colors.black54),
            //     )
            //   ],
            // ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            _buildReviewView(context),
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        RelatedProductsList(
          slug: slug,
          isCombo: true,
        ),
        // buildTrending()
      ],
    );
  }

  _buildSameSellerProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  tr("From same seller"),
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
        SameSellerList(
          slug: slug,
          isCombo: true,
        ),
        // buildTrending()
      ],
    );
  }

  _buildReviewView(BuildContext context) {
    return StreamBuilder<ReviewResponse>(
      stream: reviewBloc.review.stream,
      builder: (context, AsyncSnapshot<ReviewResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildReviewListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget(context);
        }
      },
    );
  }

  _buildReviewListWidget(ReviewResponse data) {
    List<Review> reviews = data.reviews;
    if (reviews.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This product has no reviews.",
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            )
          ],
        ),
      );
    } else
      return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: reviews.map((Review review) {
            final children = <Widget>[];
            for (int i = 0; i < review.imageThumbnail?.length ?? 0; i++) {
              print("adding children:" + review.imageThumbnail[i]);
              children.add(Container(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image(
                      image: NetworkImage(review.imageThumbnail[i]),
                      height: 60,
                    )
//                CachedNetworkImage(
//                  placeholder: (context, url) => Center(
//                    child: Container(
//                      height: 300,
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage("assets/images/placeholder.png"),
//                            fit: BoxFit.contain),
//                      ),
//                    ),
//                  ),
//                  imageUrl: "http://ecsite.eeeinnovation.com/storage/uploads/reviews/thumbnails/pro16030376885f8c69f8b4e883.png",
//                  imageBuilder: (context, imageProvider) => Container(
//                    height: 300,
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                      image: imageProvider,
//                      fit: BoxFit.cover,
//                    )),
//                  ),
//                  errorWidget: (context, url, error) => Center(
//                    child: Container(
//                      height: 300,
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage("assets/images/placeholder.png"),
//                            fit: BoxFit.cover),
//                      ),
//                    ),
//                  ),
//                ),
                    ),
              ));
            }
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(review.customerImage),
              ),
              title: Column(
                children: [
                  Row(
                    children: [Text(review.userName)],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      StarRating(rating: review.rating, size: 15),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "12 Sep 2019",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.headline),
                  Text(review.message),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(child: Row(children: children))),
                ],
              ),
            );
          }).toList());
  }
}
