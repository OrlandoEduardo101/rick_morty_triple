import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/infra/datasource/login_datasource.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';

class HomeDatasouce implements IHomeDatasource {
  //final Dio _dio;

  HomeDatasouce();
  @override
  Future<List<CharacterModel>> getCharacters() async {
    
    var _response;
    HttpClient client = HttpClient();
    try {
      final completer = Completer<String>();
      final contents = StringBuffer();
      //response = await _dio.get('/character');
      HttpClientRequest request = await client
          .getUrl(Uri.parse("https://rickandmortyapi.com/api/character"));
      HttpClientResponse response = await request.close();
      response.transform(utf8.decoder).listen((data) {
    contents.write(data);
  }, onDone: () => completer.complete(contents.toString()));

      _response = await completer.future;

    } catch (e) {
      throw ConnectionError(message: 'erro ao buscar dados');
    }

    debugPrint('$_response');

    var list = <CharacterModel>[];

    var decode = jsonDecode(_response);

    for (var json in decode['results'] as List) {
      var item = CharacterModel.fromMap(json);
      debugPrint(item.toJson().toString());
      list.add(item);
    }
    return list;
  }
}
