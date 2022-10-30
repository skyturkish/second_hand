import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/product/utilities/network_change/network_change_manager.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({Key? key}) : super(key: key);

  @override
  State<NoNetworkWidget> createState() => NoNetworkWidgetState();
}

class NoNetworkWidgetState extends State<NoNetworkWidget> {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;

  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    fetchFirstResult();
    _networkChange.handleNetworkChange((result) {
      _updateView(result);
    });
  }

  void fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Waiting for internet connection...', style: Theme.of(context).textTheme.subtitle1),
            const LottieAnimationView(animation: LottieAnimation.noInternet),
          ],
        ),
      ),
      secondChild: const SizedBox.shrink(),
      crossFadeState: _networkResult == NetworkResult.OFF ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(seconds: 1),
    );
  }
}
