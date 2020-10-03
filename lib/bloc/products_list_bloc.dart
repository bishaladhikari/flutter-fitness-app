import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/related_product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductResponse> _forYou =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _featured =
  BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _related =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _fromSameSeller =
      BehaviorSubject<ProductResponse>();

  getProducts() async {
    ProductResponse response = await _repository.getProducts();
    _forYou.sink.add(response);
  }
  getFeaturedProducts() async {
    ProductResponse response = await _repository.getFeaturedProducts();
    _featured.sink.add(response);
  }
  getRelatedProduct() async {
    ProductResponse response = await _repository.getRelatedProduct();
    _related.sink.add(response);
  }
  getSameSellerProduct() async {
    ProductResponse response = await _repository.getSameSellerProduct();
    _fromSameSeller.sink.add(response);
  }

  dispose() {
    _forYou.close();
    _featured.close();
    _related.close();
    _fromSameSeller.close();
  }

  BehaviorSubject<ProductResponse> get forYou => _forYou;
  BehaviorSubject<ProductResponse> get featured => _featured;
  BehaviorSubject<ProductResponse> get related => _related;
  BehaviorSubject<ProductResponse> get fromSameSeller => _fromSameSeller;
}

final productsBloc = ProductsListBloc();

