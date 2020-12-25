import 'package:dartz/dartz.dart';
import 'package:rick_morty_triple/app/modules/home/domain/entities/character_entity.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/domain/repository/home_repository.dart';
import 'package:rick_morty_triple/app/modules/home/infra/datasource/login_datasource.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

class HomeRepository implements IHomeRepository {
  final IHomeDatasource datasource;

  HomeRepository(this.datasource);
  @override
  Future<Either<HomeFailure, List<CharacterEntity>>> getCharacters() async {
    List<CharacterModel> listModel;
    try {
      listModel = await datasource.getCharacters();
    } catch (e) {
      return Left(ErrorGetChar(message: 'Error ao buscar personagens $e'));
    }
    return Right(listModel);
  }
}
