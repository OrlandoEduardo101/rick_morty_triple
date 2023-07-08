import 'package:flutter_triple/flutter_triple.dart';

import '../domain/entities/character_entity.dart';

// ignore: must_be_immutable
class HomeStore extends Store<List<CharacterEntity>> {
  HomeStore() : super([]);

  final isLoadingState = RxNotifier<bool>(true);
  final errorState = RxNotifier<Error?>(null);

  final _fullList = RxNotifier<List<CharacterEntity>>([]);
  List<CharacterEntity> get fullList => _fullList.value;
  set fullList(List<CharacterEntity> value) => _fullList.value = value;

  final getCharAction = RxNotifier.action();
  final setlistSearch = RxNotifier<String>('');
}
