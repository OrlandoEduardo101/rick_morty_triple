
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/infra/drivers/connectivity_driver.dart';
import 'package:rick_morty_triple/app/modules/home/infra/services/connectivity_service.dart';

class ConnectivityDriverMock extends Mock implements IConnectivityDriver {}

main() {
  final driver = ConnectivityDriverMock();
  final service = ConnectivityService(driver);
  test('deve retornar um bool', () async {
    when(driver.isOnline).thenAnswer((_) async => true);
    var result = await service.isOnline();
      expect(result, isA<Right<dynamic, Unit>>());
  });
  test('deve retornar um erro de conexão', () async {
    when(driver.isOnline).thenThrow(ConnectionError());
    var result = await service.isOnline();
      expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
