import 'package:flutter/foundation.dart';

extension IfDebugging on String {
  String? get ifDebugging => kDebugMode ? this : null;
}
