import 'package:flutter/widgets.dart';

class ReusableWidgets {
  static SizedBox getSizedBox({
    double height = 0.0,
    double width = 0.0,
  }) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
