import 'package:dartz/dartz.dart';
import 'package:rick_morty_triple/app/modules/home/domain/entities/character_entity.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/domain/repository/home_repository.dart';
import 'package:rick_morty_triple/app/modules/home/domain/services/connectivity_service.dart';

abstract class IGetCharacter {
  Future<Either<HomeFailure, List<CharacterEntity>>> call();
}

class GetCharacter implements IGetCharacter {
  final IHomeRepository repository;
  final IConnectivityService service;

  GetCharacter(this.repository, this.service);
  @override
  Future<Either<HomeFailure, List<CharacterEntity>>> call() async {
    var result = await service.isOnline();

    if (result.isLeft()) {
      return result.map((r) => null);
    }

    return await repository.getCharacters();
  }
  
}
