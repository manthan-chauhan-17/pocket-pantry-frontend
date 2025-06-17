import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
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

  static SnackBar getSnackBar({
    required String title,
    required String message,
    required ContentType contentType,
    SnackBarBehavior snackBarBehaviour = SnackBarBehavior.floating,
  }) {
    return SnackBar(
      elevation: 0,
      behavior: snackBarBehaviour,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
  }
}
