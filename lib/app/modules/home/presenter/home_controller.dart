import 'package:mobx/mobx.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/domain/usecases/get_character.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

class HomeController extends MobXStore<MyState, HomeFailure> {
  final IGetCharacter _usecase;

  HomeController(this._usecase) : super(MyState.loading) {
    fetchChar = Action(_fetchChar);
    listSearch = Action(_listSearch);
    _setError = Action(_setErrorAction);
    getChar();
  }

  final _listChar = Observable(<CharacterModel>[]);
  List get listChart => _listChar.value;

  set value(newValue) => _listChar.value = newValue;
  Action fetchChar;

  final _listResult = Observable(<CharacterModel>[]);

  List get listResult => _listResult.value;

  set listResult(value) => _listResult.value = value;

  Action listSearch;

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
    setState(MyState.state);
    setLoading(false);
    _listChar.value = list;
  }

  List _list = <CharacterModel>[];
  setlistSearch(value) {
    _listChar.value.forEach((element) {
      if (element.name.contains(value)) {
        _list.add(element);
      }
    });

    if (_list.isEmpty || _list == null) {
      _setError();
    } else{
      listSearch();
    }


    _list = <CharacterModel>[];
  }

  Action _setError;
  _setErrorAction() {
    setError(ErrorSearch(message: 'Nenhuma correspondência'));
    setState(MyState.error);
  }

  _listSearch() {
    setState(MyState.state);
    _listResult.value = _list;
  }
}

/*class MyState extends State {
  MyState(run) : super(run);
}*/
enum MyState { state, loading, error }
