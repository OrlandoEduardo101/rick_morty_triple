import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/infra/datasource/login_datasource.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';
import 'package:rick_morty_triple/app/modules/home/infra/repository/home_repository.dart';

class HomeDataSourceMock extends Mock implements IHomeDatasource {}

main() {
  final datasource = HomeDataSourceMock();
  final repository = HomeRepository(datasource);

  test('deve retornar uma lista de personagens', () async {
    when(datasource.getCharacters())
        .thenAnswer((_) async => [CharacterModel()]);
    var result = await repository.getCharacters();
    expect(result.fold((l) => l, (r) => r), isA<List<CharacterModel>>());
  });

  test('deve retornar uma lista de personagens', () async {
    when(datasource.getCharacters())
        .thenThrow(Exception());
    var result = await repository.getCharacters();
    expect(result.fold((l) => l, (r) => r), isA<ErrorGetChar>());
  });
}
