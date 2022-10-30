import 'package:flutter/material.dart';
import 'package:second_hand/product/utilities/network_change/no_network_widget.dart';

class MainBuild {
  MainBuild._();
  static Widget build(BuildContext context, Widget? child) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: child ?? const SizedBox.shrink(),
          ),
          const NoNetworkWidget(),
        ],
      ),
    );
  }
}
