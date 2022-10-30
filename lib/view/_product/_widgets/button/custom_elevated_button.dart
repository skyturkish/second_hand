import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.dynamicHeight = 0.06,
    this.dynamicWidth = 0.9,
    this.borderRadius = 45,
    this.elevation = 6,
  });
  final void Function()? onPressed;
  final Widget child;
  final double elevation;

  ///  give double value between 0.0 - 1.0
  final double dynamicHeight;

  ///  give double value between 0.0 - 1.0
  final double dynamicWidth;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(dynamicHeight),
      width: context.dynamicWidth(dynamicWidth),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: context.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
