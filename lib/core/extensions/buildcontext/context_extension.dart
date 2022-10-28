import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  static const double multiplicand = 0.01323;

  double get smallValue => height * multiplicand * 1;
  double get mediumValue => height * multiplicand * 2;
  double get largeValue => height * multiplicand * 3;
  double get largeXValue => height * multiplicand * 4;
  double get largeXXValue => height * multiplicand * 5;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionOnlyTop on BuildContext {
  EdgeInsets get paddingOnlyTopSmall => EdgeInsets.only(top: smallValue);
  EdgeInsets get paddingOnlyTopMedium => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingOnlyTopLarge => EdgeInsets.only(top: largeValue);
  EdgeInsets get paddingOnlyTopLargeX => EdgeInsets.only(top: largeXValue);
  EdgeInsets get paddingOnlyTopLargeXX => EdgeInsets.only(top: largeXXValue);
  EdgeInsets get paddingOnlyTopLargeToo => EdgeInsets.only(top: largeXXValue * 3);
}

extension PaddingExtensionOnlyBottom on BuildContext {
  EdgeInsets get paddingOnlyBottomSmall => EdgeInsets.only(bottom: smallValue);
  EdgeInsets get paddingOnlyBottomMedium => EdgeInsets.only(bottom: mediumValue);
  EdgeInsets get paddingOnlyBottomLarge => EdgeInsets.only(bottom: largeValue);
  EdgeInsets get paddingOnlyBottomLargeX => EdgeInsets.only(bottom: largeXValue);
  EdgeInsets get paddingOnlyBottomLargeXX => EdgeInsets.only(bottom: largeXXValue);
}

extension PaddingExtensionOnlyLeft on BuildContext {
  EdgeInsets get paddingOnlyLeftSmallX => EdgeInsets.only(left: smallValue * 3 / 4);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingHorizontalSmall => EdgeInsets.symmetric(horizontal: smallValue);
  EdgeInsets get paddingHorizontalMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHorizontalLarge => EdgeInsets.symmetric(horizontal: largeValue);
  EdgeInsets get paddingHorizontalLargeX => EdgeInsets.symmetric(horizontal: largeXValue);
  EdgeInsets get paddingHorizontalLargeXX => EdgeInsets.symmetric(horizontal: largeXXValue);

  EdgeInsets get paddingVerticalSmall => EdgeInsets.symmetric(vertical: smallValue);
  EdgeInsets get paddingVerticalMedium => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingVerticalLarge => EdgeInsets.symmetric(vertical: largeValue);
  EdgeInsets get paddingVerticalLargeX => EdgeInsets.symmetric(vertical: largeXValue);
  EdgeInsets get paddingVerticaLargeXX => EdgeInsets.symmetric(vertical: largeXXValue);
}

extension PaddingAll on BuildContext {
  EdgeInsets get paddingAllSmall => EdgeInsets.all(smallValue);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingAllLarge => EdgeInsets.all(largeValue);
  EdgeInsets get paddingAllLargeX => EdgeInsets.all(largeXValue);
  EdgeInsets get paddingAllLargeXX => EdgeInsets.all(largeXXValue);
}
