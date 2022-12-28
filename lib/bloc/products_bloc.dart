import 'package:fitnessive/models/response/product_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc {
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

  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  final BehaviorSubject<String> _storeSlug = BehaviorSubject<String>();
  final BehaviorSubject<int> _page = BehaviorSubject<int>();

  ProductResponse productResponse;

  getProducts() async {
    // ProductResponse response = await _repository.getProducts(page);
    // _forYou.sink.add(response);

    _loading.sink.add(true);
    var params = {"page": _page.value, "store": _storeSlug.value};
    ProductResponse response = await _repository.getProducts(params);

    if (response.error == null) {
      if (productResponse != null && productResponse.products.length > 0) {
        productResponse.products.addAll(response.products);
      } else {
        productResponse = response;
      }
    } else {
      productResponse = response;
    }

    _loading.sink.add(false);
    _forYou.sink.add(productResponse);
    // return orderResponse;
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

  BehaviorSubject<int> get page => _page;

  BehaviorSubject<String> get storeSlug => _storeSlug;

  Stream<bool> get loading => _loading.stream;
}

final productsBloc = ProductsBloc();
