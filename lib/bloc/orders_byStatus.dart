import 'package:ecapp/models/response/order_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class OrdersListByStatusBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<OrderResponse> _orders =
      BehaviorSubject<OrderResponse>();

  getOrdersByStatus(String status, int pageNumber) async {
    OrderResponse response = await _repository.getOrdersByStatus(status, pageNumber);
    _orders.sink.add(response);
  }

  void drainStream() {
    _orders.value = null;
  }

  void dispose() async {
    await _orders.drain();
    _orders.close();
  }

  BehaviorSubject<OrderResponse> get orders => _orders;
}
