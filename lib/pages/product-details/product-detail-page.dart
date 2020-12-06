import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/product_detail_bloc.dart';
import 'package:ecapp/bloc/review_bloc.dart';
import 'package:ecapp/components/star_rating.dart';
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/attribute_image.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/product_detail.dart';
import 'package:ecapp/models/response/add_to_cart_response.dart';
import 'package:ecapp/models/response/add_to_wishlist.dart';
import 'package:ecapp/models/response/cart_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/models/response/remove_from_wishlist.dart';
import 'package:ecapp/models/response/review_response.dart';
import 'package:ecapp/models/review.dart';
import 'package:ecapp/models/variant.dart';
import 'package:ecapp/pages/product-details/components/add_to_cart.dart';
import 'package:ecapp/widgets/dotted_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_fab/sliver_fab.dart';
import '../../constants.dart';
import 'components/related_products_list.dart';
import 'components/same_seller_list.dart';
import 'components/detail_widget.dart';
import 'components/widgets/price.dart';
import 'components/widgets/variants.dart';

int ctQuantity = 1;

// ignore: must_be_immutable
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

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();

  static _ProductDetailPageState of(BuildContext context) {
    final _ProductDetailPageState navigator = context
        // ignore: deprecated_member_use
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

//  double myscroll = 1;
//  double appBarV = 0;
//  bool isClicked = false;
  int quantity = 1;
  ProductDetailBloc productDetailBloc;
  String slug;
  AnimationController _animationController;
  Animation _opacityTween;
  ReviewBloc reviewBloc = ReviewBloc();

  _ProductDetailPageState();

  @override
  void initState() {
    super.initState();

    productDetailBloc = ProductDetailBloc();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _opacityTween = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    slug = widget.product.slug;

    productDetailBloc.getProductDetail(slug);
    reviewBloc.getProductReview("false", slug, 1);
  }

  @override
  void dispose() {
    super.dispose();
    productDetailBloc.drainStream();
    reviewBloc.drainStream();
  }

  addToCart(context, params, checkout) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      AddToCartResponse response = await cartBloc.addToCart(params);
      if (response.error != null) {
        if (!checkout) Navigator.pop(context);
        var snackbar = SnackBar(
          content: Text(response.error),
          backgroundColor: Colors.redAccent,
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        var snackbar = SnackBar(
          content: Row(
            children: [
              Text(tr("Item added to cart")),
              Spacer(),
//            GestureDetector(onTap: () {}, child: Text("Go to cart",style: TextStyle(color: Colors.red),))
            ],
          ),
          backgroundColor: NPrimaryColor,
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
        if (checkout) Navigator.pushNamed(context, "checkoutPage");
      }
    }
  }

  _addToWishlist(context) async {
    if (!await authBloc.isAuthenticated())
      Navigator.pushNamed(context, "loginPage");
    else {
      AddToWishlistResponse response = await productDetailBloc.addToWishlist();
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
          await productDetailBloc.deleteFromWishlist();
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

  Widget _buildQuantity() {
    return Row(
      children: [
        Text(
          "Quantity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
//        Spacer(),
        IconButton(
          icon: Icon(
            Icons.remove,
            color: Colors.black87.withOpacity(0.5),
            size: 20,
          ),
          splashRadius: 5.0,
          onPressed: () {
            setState(() {
              quantity--;
            });
          },
        ),
        Container(
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kForeGroundColor)),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Center(
            child: Text(
              quantity.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black87.withOpacity(0.5),
            size: 20,
          ),
          splashRadius: 5.0,
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          NotificationListener<ScrollUpdateNotification>(
            child: SliverFab(
              floatingPosition: FloatingPosition(right: 20),
              floatingWidget: StreamBuilder<ProductDetailResponse>(
                stream: productDetailBloc.subject.stream,
                builder:
                    (context, AsyncSnapshot<ProductDetailResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0) {
                      return _buildErrorWidget(snapshot.data.error);
                    }
                    return _buildAddToWishListWidget(context, snapshot.data);
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else {
                    return Container();
                  }
                },
              ),
              expandedHeight: 290.0,
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
                            child: Text(widget.product.name));
                      }),
                  flexibleSpace: FlexibleSpaceBar(
                    background: StreamBuilder<ProductDetailResponse>(
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
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.product.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<ProductDetailResponse>(
                              stream: productDetailBloc.subject.stream,
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
                                  return _buildLoadingWidget();
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          // _buildProducts(context),
                          StreamBuilder<ProductDetailResponse>(
                              stream: productDetailBloc.subject.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var productDetail =
                                      snapshot.data.productDetail;
                                  return Column(
                                    children: [
                                      RelatedProductsList(slug: slug),
                                      SameSellerList(
                                          slug: slug,
                                          productDetail: productDetail),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          _buildReviews(context),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.vertical) {
                _animationController
                    .animateTo(notification.metrics.pixels / 400);
                return true;
              }
              return false;
            },
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<ProductDetailResponse>(
          stream: productDetailBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var productDetail = snapshot.data.productDetail;
              var attributeId = productDetail?.selectedAttribute?.id;
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
                                    tr("Add to cart"),
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
                                        productDetail: productDetail,
                                        productDetailBloc: productDetailBloc);
                                  });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      FlatButton(
                        onPressed: () async {
                          var params = {
                            "attribute_id": attributeId,
                            "combo_id": null,
                            "quantity": 1
                          };
                          addToCart(context, params, true);
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

  _buildDetailWidget(ProductDetailResponse data) {
    ProductDetail productDetail = data.productDetail;
//    final controller = AnimationController(
//      vsync: this,
//        duration: Duration(milliseconds: 500));
//    final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
//    controller.forward();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, "storePage",
                  arguments: productDetail.storeSlug)
            },
            child: Row(
              children: [
                Text(
                  tr("Sold By:"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  productDetail.soldBy,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              StarRating(rating: productDetail.avgRating, size: 10),
              SizedBox(
                width: 8,
              ),
              // Text("(3) reviews"),
              Text("(" + productDetail.reviewCount.toString() + ")"),
              SizedBox(width: 2.0),
              Text(tr("reviews")),
//              Spacer(),
//              IconButton(
//                icon: Icon(Icons.favorite_border,color: Colors.black26,), onPressed: () {  },
//              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          DetailWidget(
              productDetail: productDetail,
              productDetailBloc: productDetailBloc),
        ],
      ),
    );
  }

  Widget _buildAddToWishListWidget(context, ProductDetailResponse data) {
    ProductDetail productDetail = data.productDetail;
    var saved = productDetail.selectedAttribute.saved;
    return FloatingActionButton(
      backgroundColor: saved ? NPrimaryColor : Colors.white,
      onPressed: () {
        if (saved)
          _removeFromWishlist(context);
        else
          _addToWishlist(context);
      },
      child: Icon(
        Icons.favorite_border,
        color: saved ? Colors.white : Colors.black38,
      ),
    );
  }

  Widget _buildBottomSheet(context) {
    return StreamBuilder<ProductDetailResponse>(
        stream: productDetailBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var productDetail = snapshot.data.productDetail;
            var attributeId = productDetail?.selectedAttribute?.id;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                  ProductPrice(productDetail: productDetail),
                  Variants(
                      productDetail: productDetail,
                      productDetailBloc: productDetailBloc),
                  _buildQuantity(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: NPrimaryColor,
                      onPressed: () async {
                        var params = {
                          "attribute_id": attributeId,
                          "combo_id": null,
                          "quantity": quantity
                        };
                        addToCart(context, params, false);
                      },
                      child: Text(
                        tr("Add to cart"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else
            return Container();
        });
  }

  Widget _buildLoadingWidget() {
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

  Widget _productSlideImage(String imageUrl) {
//    imageUrl = imageUrl != null ? imageUrl : "assets/images/placeholder.png";
    return Center(
      child: Hero(
        tag: widget.product.heroTag,
        child: CachedNetworkImage(
          placeholder: (context, url) => Center(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
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
  }

  Widget dottedSlider(images) {
    final children = <Widget>[];
    for (int i = 0; i < images?.length ?? 0; i++) {
      if (images[i] == null) {
        children.add(Center(child: CircularProgressIndicator()));
      } else {
        children.add(_productSlideImage(images[i].imageThumbnail));
      }
    }
    return DottedSlider(
      maxHeight: 300,
      children: children,
      color: NPrimaryColor,
    );
  }

  _buildReviews(BuildContext context) {
    return StreamBuilder<ProductDetailResponse>(
        stream: productDetailBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProductDetail productDetail = snapshot.data.productDetail;
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
                          "Ratings",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(15.0),
                            child: Column(children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    productDetail.avgRating.toString() + "/5",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 40,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  StarRating(
                                      rating: productDetail.avgRating,
                                      size: 15),
                                  SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    productDetail.reviewCount.toString() +
                                        " Customer Ratings",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ])),
                        SizedBox(
                          child: VerticalDivider(
                            color: Colors.black12,
                            thickness: 1,
                            // height: 4,
                          ),
                          height: 100,
                        ),
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      StarRating(rating: 5, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        child: Divider(
                                          thickness: 2,
                                          color: kPrimaryColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        productDetail.fiveStarCount.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      StarRating(rating: 5, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        child: Divider(
                                          thickness: 2,
                                          color: kPrimaryColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        productDetail.fourStarCount.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      StarRating(rating: 4, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        child: Divider(
                                          thickness: 2,
                                          color: kPrimaryColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        productDetail.threeStarCount.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      StarRating(rating: 2, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        child: Divider(
                                          thickness: 2,
                                          color: kPrimaryColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        productDetail.twoStarCount.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      StarRating(rating: 1, size: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        child: Divider(
                                          thickness: 2,
                                          color: kPrimaryColor.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        productDetail.oneStarCount.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ])),
                      ],
                    ),
                    SizedBox(
                      child: Divider(
                        color: Colors.black26,
                        height: 4,
                      ),
                      height: 24,
                    ),
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
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushNamed(context, "ratingsReviewsPage",
                                arguments: productDetail)
                          },
                          child: Text(
                            "View All",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     StarRating(rating: productDetail.avgRating, size: 20),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     Text(
                    //       productDetail.reviewCount.toString() + " Reviews",
                    //       style: TextStyle(color: Colors.black54),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   child: Divider(
                    //     color: Colors.black26,
                    //     height: 4,
                    //   ),
                    //   height: 24,
                    // ),
                    _buildReviewsView(context),
                    // ListTile(
                    //   leading: CircleAvatar(
                    //     backgroundImage: NetworkImage(
                    //         "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                    //   ),
                    //   subtitle: Text(
                    //       "Cats are good pets, for they are clean and are not noisy."),
                    //   title: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: <Widget>[
                    //       StarRating(rating: 4, size: 15),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //       Text(
                    //         "12 Sep 2019",
                    //         style: TextStyle(fontSize: 12, color: Colors.black54),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          } else
            return Container();
        });
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

  _buildReviewsView(BuildContext context) {
    return StreamBuilder<ReviewResponse>(
      stream: reviewBloc.subject.stream,
      builder: (context, AsyncSnapshot<ReviewResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildReviewListWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
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
              children.add(Container(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image(
                      image: NetworkImage(review.imageThumbnail[i]),
                      height: 60,
                    )),
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
                        review.reviewedDate,
                        style: TextStyle(fontSize: 10, color: Colors.black54),
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
//
//class ChangeQuantity extends StatefulWidget {
//  final product;
//
//  const ChangeQuantity({Key key, this.product}) : super(key: key);
//
//
//
//
//  _ChangeQuantityState createState() => _ChangeQuantityState();
//}
//
//class _ChangeQuantityState extends State<ChangeQuantity> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(10),
//      height: 300,
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
//
//        children: [
//          Text(widget.product.name, style: TextStyle(color:Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
//          Text('@ '+widget.product.sellingPrice, style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.normal),),
//          Padding(
//            padding: const EdgeInsets.only(top:8.0),
//            child: Text("Quantity", style: TextStyle(color:Colors.black, fontSize: 20),),
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              IconButton(
//                icon: Icon(Icons.remove),
//                onPressed: () {
//                  setState(() {
//                    if (ctQuantity > 1) {
//                      ctQuantity -= 1;
//                    }
//                  });
//                },
//              ),
//              Text(
//                ctQuantity.toString(),
//                style: TextStyle(color: Colors.black),
//              ),
//              IconButton(
//                icon: Icon(Icons.add),
//                onPressed: () {
//                  setState(() {
//                    ctQuantity += 1;
//                    print(ctQuantity);
//                  });
//                },
//              )
//            ],
//          ),
//          RaisedButton(
//            onPressed: () => null,
//            color: Colors.blue.withOpacity(.2 ),
//            elevation: 0.4,
//
////              width:double.infinity,
//            child: Text("Add To Cart", style: TextStyle(color:Colors.white),),
//          )
//        ],
//      ),
//    );
//  }
//}
