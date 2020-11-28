import 'package:ecapp/models/response/combo_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ComboBloc {
  final Repository _repository = Repository();

  final BehaviorSubject<ComboResponse> _subject =
      BehaviorSubject<ComboResponse>();
  final BehaviorSubject<int> _page = BehaviorSubject<int>();
  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>();
  final BehaviorSubject<String> _storeSlug = BehaviorSubject<String>();

  ComboResponse comboResponse;

  ComboBloc() {
    _page.value = 1;
    _storeSlug.value = null;
  }

  getComboProducts() async {
    _loading.sink.add(true);
    print(['ho ra again', _storeSlug.value]);
    var params = {"page": _page.value, "store": _storeSlug.value};
    ComboResponse response = await _repository.getComboProducts(params);

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
    _subject.sink.add(comboResponse);
  }

  drainComboStream() {
    _subject.value = null;
    _storeSlug.value = null;
    _page.value = 1;
  }

  dispose() {
    _subject.close();
    _storeSlug.close();
    _page.close();
  }

  BehaviorSubject<ComboResponse> get subject => _subject;

  BehaviorSubject<int> get page => _page;

  BehaviorSubject<String> get storeSlug => _storeSlug;

  Stream<bool> get loading => _loading.stream;
}

final comboBloc = ComboBloc();
