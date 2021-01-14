// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/external/datasources/home_datasource.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = HomeDatasouce();

  test('Deve retornar uma lista', () async {
    when(dio.get(any, options: anyNamed('options')))
        .thenAnswer((_) async => Response(data: jsonDecode(response)));
    var result = await datasource.getCharacters();
    expect(result, isA<List<CharacterModel>>());
  });

  test('Deve retornar um erro de erro de conexão', () async {
    when(dio.get(any, options: anyNamed('options'))).thenThrow(Exception());
    var result = datasource.getCharacters();
    expect(result, throwsA(isA<ConnectionError>()));
  });
}

var response = '''
{
  "info": {
    "count": 671,
    "pages": 34,
    "next": "https://rickandmortyapi.com/api/character/?page=2",
    "prev": null
  },
  "results": [
    {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "type": "",
      "gender": "Male",
      "origin": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/1"
      },
      "location": {
        "name": "Earth",
        "url": "https://rickandmortyapi.com/api/location/20"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "episode": [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2"
      ],
      "url": "https://rickandmortyapi.com/api/character/1",
      "created": "2017-11-04T18:48:46.250Z"
    }
  ]
}
''';
