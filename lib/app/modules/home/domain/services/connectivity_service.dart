import 'package:dartz/dartz.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';

abstract class IConnectivityService {
  Future<Either<HomeFailure, Unit>> isOnline();
}