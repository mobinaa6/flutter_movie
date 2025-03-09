import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

class InternetChecker {
  static FlutterNetworkConnectivity _flutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
  );
  static Future<bool> checkConnection() async {
    var _isInternetAvailableStreamStatus =
        await _flutterNetworkConnectivity.isInternetConnectionAvailable();

    return _isInternetAvailableStreamStatus;
  }
}
