import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static const String error = 'Error';
  static const String success = 'Success';
  static const String warning = 'Warning';
  static const String info = 'Info';

  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: message,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarningSnackbar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Warning',
        message: message,
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showInfoSnackbar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Info',
        message: message,
        contentType: ContentType.help,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
