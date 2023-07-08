import 'package:flutter_modular/flutter_modular.dart';
import 'package:rick_morty_triple/app/modules/home/domain/services/connectivity_service.dart';
import 'package:rick_morty_triple/app/modules/home/domain/usecases/get_character.dart';
import 'package:rick_morty_triple/app/modules/home/presenter/home_reducer.dart';

import 'domain/repository/home_repository.dart';
import 'external/datasources/home_datasource.dart';
import 'external/drivers/flutter_connectivity_driver.dart';
import 'infra/datasource/login_datasource.dart';
import 'infra/drivers/connectivity_driver.dart';
import 'infra/repository/home_repository.dart';
import 'infra/services/connectivity_service.dart';
import 'presenter/home_page.dart';
import 'presenter/home_store.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //domain
        Bind<GetCharacter>((i) => GetCharacter(i()!, i()!)),

        //infra
        Bind<IHomeRepository>((i) => HomeRepository(i()!)),
        Bind<IConnectivityService>((i) => ConnectivityService(i()!)),

        //external
        Bind<IHomeDatasource>((i) => HomeDatasouce()),
        Bind<IConnectivityDriver>((i) => FlutterConnectivityDriver(i()!)),

        //presenter
        Bind((i) => HomeStore()),
        Bind((i) => HomeReducer(i()!, i()!), isLazy: false),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];

  // static Inject get to => Inject<HomeModule>.of();
}
