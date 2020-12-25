import 'origin_entity.dart';

class CharacterEntity {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  OriginEntity origin;
  OriginEntity location;
  String image;
  List<String> episode;
  String url;
  String created;
  CharacterEntity({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });
}
