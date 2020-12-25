import 'package:connectivity/connectivity.dart';
import '../../infra/drivers/connectivity_driver.dart';

class  FlutterConnectivityDriver implements IConnectivityDriver {
  final Connectivity connectivity;

  FlutterConnectivityDriver(this.connectivity);
  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
  
}