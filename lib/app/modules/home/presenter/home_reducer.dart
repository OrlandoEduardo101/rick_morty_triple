import 'package:flutter_triple/flutter_triple.dart';

import '../domain/entities/character_entity.dart';
import '../domain/errors/error.dart';
import '../domain/usecases/get_character.dart';
import 'home_store.dart';

class HomeReducer extends RxReducer {
  final IGetCharacter _usecase;
  final HomeStore store;

  HomeReducer(this._usecase, this.store) {
    on(() => [store.getCharAction], getChar);
    on(() => [store.setlistSearch], setlistSearch);
  }

  var listLocal = <CharacterEntity>[];

  Future getChar() async {
    store.setLoading(true);
    var result = await _usecase();
    result.fold((l) {
      store.setError(l);
      store.setLoading(false);
    }, (r) {
      store.fullList = r;
      fetchChar();
    });
  }

  fetchChar() {
    store.setLoading(false);
    if (listLocal.isEmpty) {
      store.update(store.fullList);
    } else {
      store.update(listLocal);
    }
  }

  setlistSearch() {
    final value = store.setlistSearch.value;
    if (value.isNotEmpty) {
      store.state.forEach((element) {
        if (element.name!.toLowerCase().contains(value.toLowerCase())) {
          listLocal.add(element);
        }
      });

      if (listLocal.isEmpty) {
        store.setError(ErrorSearch(message: 'Nenhuma correspondência'));
      } else {
        fetchChar();
        listLocal = [];
      }
    } else {
      fetchChar();
    }
  }
}
