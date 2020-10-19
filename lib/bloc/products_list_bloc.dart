import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ProductResponse> _forYou =
      BehaviorSubject<ProductResponse>();

  final BehaviorSubject<ProductResponse> _featured =
      BehaviorSubject<ProductResponse>();

  final BehaviorSubject<ProductResponse> _newArrivals =
      BehaviorSubject<ProductResponse>();

  final BehaviorSubject<ProductResponse> _bestSellers =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _topRated =
      BehaviorSubject<ProductResponse>();

  getProducts() async {
    ProductResponse response = await _repository.getProducts();
    _forYou.sink.add(response);
  }

  getFeaturedProducts() async {
    ProductResponse response = await _repository.getFeaturedProducts();
    _featured.sink.add(response);
  }

  getBestSellers() async {
    ProductResponse response = await _repository.getBestSellers();
    _bestSellers.sink.add(response);
  }

  getTopRated() async {
    ProductResponse response = await _repository.getTopRated();
    _topRated.sink.add(response);
  }

  getNewArrivals() async {
    ProductResponse response = await _repository.getNewArrivals();
    _newArrivals.sink.add(response);
  }

  drainBestSellersStream() {
    _bestSellers.value = null;
  }

  drainNewArrivalsStream() {
    _newArrivals.value = null;
  }

  drainTopRatedStream() {
    _topRated.value = null;
  }

  dispose() {
    _forYou.close();
    _featured.close();
    _bestSellers.close();
    _newArrivals.close();
  }

  BehaviorSubject<ProductResponse> get forYou => _forYou;

  BehaviorSubject<ProductResponse> get featured => _featured;

  BehaviorSubject<ProductResponse> get bestSellers => _bestSellers;

  BehaviorSubject<ProductResponse> get newArrivals => _newArrivals;

  BehaviorSubject<ProductResponse> get topRated => _topRated;
}

final productsBloc = ProductsListBloc();
