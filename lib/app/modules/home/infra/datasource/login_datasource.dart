
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

abstract class IHomeDatasource {
  Future<List<CharacterModel>> getCharacters();
}
