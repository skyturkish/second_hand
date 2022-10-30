// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';

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
