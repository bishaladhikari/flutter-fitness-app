import 'package:ecapp/models/combo.dart';
import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/models/response/product_detail_response.dart';
import 'package:ecapp/models/response/product_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ComboBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ComboResponse> _combo =
      BehaviorSubject<ComboResponse>();

  getComboProducts() async {
    ComboResponse response = await _repository.getComboProducts();
    _combo.sink.add(response);
  }

  drainComboStream() {
    _combo.value = null;
  }

  dispose() {
    _combo.close();
  }

  BehaviorSubject<ComboResponse> get combo => _combo;
}

final comboBloc = ComboBloc();
