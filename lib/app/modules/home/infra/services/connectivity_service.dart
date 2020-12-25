import 'package:dartz/dartz.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import '../../domain/services/connectivity_service.dart';
import '../drivers/connectivity_driver.dart';

class ConnectivityService implements IConnectivityService {
  final IConnectivityDriver driver;

  ConnectivityService(this.driver); 
  @override
  Future<Either<HomeFailure, Unit>> isOnline() async {
    try {
      var check = await driver.isOnline;
      if (check) {
        return Right(unit);
      }
      throw ConnectionError(message: 'Você está offline');
    } on HomeFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ConnectionError(
        message: 'Erro ao tentar verificar a conexão',
      ));
    }
  }
}