import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ComboBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ComboResponse> _combos =
      BehaviorSubject<ComboResponse>();
  final BehaviorSubject<int> _page = BehaviorSubject<int>();
  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();

  ComboResponse comboResponse;

  // getComboProducts() async {
  //   //   ComboResponse response = await _repository.getComboProducts();
  //   //   _combos.sink.add(response);
  //   // }

  ComboBloc() {
    _page.value = 1;
  }

  getComboProducts() async {
    _loading.sink.add(true);
    ComboResponse response = await _repository.getComboProducts(
      page: _page.value,
    );

    if (response.error == null) {
      if (comboResponse != null && comboResponse.combos.length > 0) {
        comboResponse.combos.addAll(response.combos);
      } else {
        comboResponse = response;
      }
    } else {
      comboResponse = response;
    }

    _loading.sink.add(false);
    _combos.sink.add(comboResponse);
  }

  drainComboStream() {
    _combos.value = null;
  }

  dispose() {
    _combos.close();
  }

  BehaviorSubject<ComboResponse> get combos => _combos;

  BehaviorSubject<int> get page => _page;

  Stream<bool> get loading => _loading.stream;
}

final comboBloc = ComboBloc();
