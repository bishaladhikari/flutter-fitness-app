import 'package:fitnessive/models/response/order_response.dart';
import 'package:fitnessive/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class OrdersListByStatusBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<OrderResponse> _subject =
      BehaviorSubject<OrderResponse>();

  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  OrderResponse orderResponse;

  getOrdersByStatus(String status, int pageNumber) async {
    _loading.sink.add(true);
    OrderResponse response = await _repository.getOrdersByStatus(status, pageNumber);

    if (response.error == null) {
      if (orderResponse != null && orderResponse.orders.length > 0) {
        orderResponse.orders.addAll(response.orders);
      } else {
        orderResponse = response;
      }
    } else {
      orderResponse = response;
    }

    _loading.sink.add(false);
    _subject.sink.add(orderResponse);
    return orderResponse;
  }

  void drainStream() {
    _subject.value = null;
  }

  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<OrderResponse> get subject => _subject;

  Stream<bool> get loading => _loading.stream;
}
