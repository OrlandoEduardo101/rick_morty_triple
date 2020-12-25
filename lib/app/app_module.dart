import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_triple/app/app_widget.dart';
import 'package:rick_morty_triple/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => Connectivity()),
        Bind((i) => Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api')))
      ];

  @override
  final List<ModularRoute> routes = [
        ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];

  @override
  Widget get bootstrap => AppWidget();

  //static Inject get to => Inject<AppModule>.of();
}
