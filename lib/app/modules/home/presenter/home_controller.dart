import 'package:mobx/mobx.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/domain/usecases/get_character.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

// ignore: must_be_immutable
class HomeController extends MobXStore<HomeFailure, List<CharacterModel>> {
  final IGetCharacter _usecase;

  HomeController(this._usecase) : super([]) {
    getChar();
  }

  final listChar = Observable(<CharacterModel>[]);
  late final fetchChar = Action(_fetchChar);
  var listLocal = <CharacterModel>[];
  var list;

  Future getChar() async {
    setLoading(true);
    var result = await _usecase();
    result.fold((l) {
      setError(l);
      setLoading(false);
    }, (r) {
      list = r;
      fetchChar();
    });
  }

  _fetchChar() {
    setLoading(false);
    if (listLocal.isEmpty) {
      update(list);
    } else {
      update(listLocal);
    }
  }

  setlistSearch(String value) {
    if (value.isNotEmpty) {
      
      state.forEach((element) {
        if (element.name!.contains(value)) {
          listLocal.add(element);
        }
      });

      if (listLocal.isEmpty) {
        setError(ErrorSearch(message: 'Nenhuma correspondência'));
      } else {
        fetchChar();
        listLocal = [];
      }

    } else {

      fetchChar();

    }
  }
  
}

enum MyState { state, loading, error }
