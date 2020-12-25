import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_triple/app/modules/home/domain/entities/character_entity.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/domain/repository/home_repository.dart';
import 'package:rick_morty_triple/app/modules/home/domain/services/connectivity_service.dart';
import 'package:rick_morty_triple/app/modules/home/domain/usecases/get_character.dart';

class RepositoryMock extends Mock implements IHomeRepository {}

class ServiceMock extends Mock implements IConnectivityService {}

main() {
  var repository = RepositoryMock();
  var service = ServiceMock();
  var usecase = GetCharacter(repository, service);
  var char = CharacterEntity();

  setUp(() {
    when(service.isOnline()).thenAnswer((_) async => Right(unit));
  });

  test('deve retornar uma lista de personagens', () async {
    when(repository.getCharacters()).thenAnswer((_) async => Right([char]));
    var result = await usecase();
    expect(result.fold(id, id), isA<List<CharacterEntity>>());
  });

  test('deve retornar um left', () async {
    when(repository.getCharacters()).thenAnswer((_) async => Left(ErrorGetChar()));
    var result = await usecase();
    expect(result, isA<Left>());
  });

  test('deve retornar um erro quando offline', () async {
    when(service.isOnline()).thenAnswer((_) async => Left(ConnectionError()));
    var result = await usecase();
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });

}
