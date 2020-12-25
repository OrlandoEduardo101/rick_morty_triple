import 'package:dartz/dartz.dart';
import 'package:rick_morty_triple/app/modules/home/domain/entities/character_entity.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';

abstract class IHomeRepository {
  Future<Either<HomeFailure, List<CharacterEntity>>> getCharacters();
}