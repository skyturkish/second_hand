import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';

import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LottieAnimationView(
          animation: LottieAnimation.notFound,
        ),
      ),
    );
  }
}
