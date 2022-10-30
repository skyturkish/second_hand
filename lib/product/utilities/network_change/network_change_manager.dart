import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:second_hand/product/utilities/network_change/network_result_enum.dart';

typedef NetworkCallBack = void Function(NetworkResult result);

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
