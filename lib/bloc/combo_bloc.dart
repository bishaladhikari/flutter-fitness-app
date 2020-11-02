import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ComboBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ComboResponse> _combos =
      BehaviorSubject<ComboResponse>();

  getComboProducts() async {
    ComboResponse response = await _repository.getComboProducts();
    _combos.sink.add(response);
  }

  drainComboStream() {
    _combos.value = null;
  }

  dispose() {
    _combos.close();
  }

  BehaviorSubject<ComboResponse> get combos => _combos;
}

final comboBloc = ComboBloc();
