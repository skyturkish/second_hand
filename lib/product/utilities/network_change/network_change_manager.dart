import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef NetworkCallBack = void Function(NetworkResult result);

enum NetworkResult {
  ON,
  OFF;

  static NetworkResult checkConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        return NetworkResult.ON;
      case ConnectivityResult.none:
        return NetworkResult.OFF;
    }
  }
}

abstract class INetworkChangeManager {
  Future<NetworkResult> checkNetworkFirstTime();
  void handleNetworkChange(NetworkCallBack onChange);
  void dispose();
}

class NetworkChangeManager extends INetworkChangeManager {
  late final Connectivity _connectivity;

  StreamSubscription<ConnectivityResult>? _subscription;

  NetworkChangeManager() {
    _connectivity = Connectivity();
  }
  @override
  Future<NetworkResult> checkNetworkFirstTime() async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    return NetworkResult.checkConnectivityResult(connectivityResult);
  }

  @override
  void handleNetworkChange(NetworkCallBack onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChange.call(NetworkResult.checkConnectivityResult(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
