import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fitnessive/bloc/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'banner_bloc.dart';
import 'cart_bloc.dart';
import 'categories_bloc.dart';

class MainBloc {

  refresh(){
    productsBloc.page.value = 1;
    productsBloc.productResponse = null;
    bannerBloc.drainStream();
    categoryBloc.drainStream();
    productsBloc.drainNewArrivalsStream();
    productsBloc.drainBestSellersStream();
    productsBloc.drainTopRatedStream();
    bannerBloc.getBanners();
    categoryBloc.getCategories();
    productsBloc.getFeaturedProducts();
    productsBloc.getBestSellers();
    productsBloc.getProducts();
    productsBloc.getNewArrivals();
    cartBloc.getCart();
  }
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      return await DataConnectionChecker().hasConnection;
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  @mustCallSuper
  void dispose() async{

  }

}

final MainBloc mainBloc = MainBloc();
