import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';

import '_product/_widgets/animation/lottie_animation_view.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LottieAnimationView(animation: LottieAnimation.notFound),
            Text('asdas'),
          ],
        ),
      ),
    );
  }
}
