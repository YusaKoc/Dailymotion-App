import 'package:dailymotion_app/core/utils/network_utils.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected => hasInternet();
}
