
import 'dart:convert';

import 'package:rick_morty_triple/app/modules/home/domain/entities/character_entity.dart';
import 'package:rick_morty_triple/app/modules/home/domain/entities/origin_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({int id, String name, String status, String species, String type, String gender, OriginEntity origin, OriginEntity location, String image, List<String> episode, String url, String created}) : super(id: id, name: name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, image: image, episode: episode, url: url, created: created);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin?.toJson(),
      'location': location?.toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      type: map['type'],
      gender: map['gender'],
      origin: OriginEntity.fromJson(map['origin']),
      location: OriginEntity.fromJson(map['location']),
      image: map['image'],
      episode: List<String>.from(map['episode']),
      url: map['url'],
      created: map['created'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) => CharacterModel.fromMap(json.decode(source));
  
}
