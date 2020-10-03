import 'package:ecapp/models/product_response.dart';
import 'package:ecapp/models/related_product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _relatedProduct =
      BehaviorSubject<ProductResponse>();
  final BehaviorSubject<ProductResponse> _sameSellerProduct =
      BehaviorSubject<ProductResponse>();

  getProducts() async {
    ProductResponse response = await _repository.getProducts();
    _subject.sink.add(response);
  }
  getRelatedProduct() async {
    ProductResponse response = await _repository.getRelatedProduct();
    _relatedProduct.sink.add(response);
  }
  getSameSellerProduct() async {
    ProductResponse response = await _repository.getSameSellerProduct();
    _sameSellerProduct.sink.add(response);
  }

  dispose() {
    _subject.close();
    _relatedProduct.close();
    _sameSellerProduct.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
  BehaviorSubject<ProductResponse> get relatedProduct => _relatedProduct;
  BehaviorSubject<ProductResponse> get sameSellerProduct => _sameSellerProduct;
}

final productsBloc = ProductsListBloc();

