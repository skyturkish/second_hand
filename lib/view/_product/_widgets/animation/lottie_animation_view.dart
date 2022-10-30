import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';

class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    super.key,
    this.repeat = true,
    this.reverse = false,
    required this.animation,
  });

  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      );
}
