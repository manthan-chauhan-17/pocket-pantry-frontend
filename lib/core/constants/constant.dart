// core/constants/constant.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String appName = 'Pocket Pantry';
  static final String apiBaseUrl = dotenv.env['env'] == 'dev'
      ? 'http://192.168.1.2:3000/api/v1/'
      : 'https://pocket-pantry-backend-dnce.onrender.com/api/v1/';
  static const double generalPadding = 16.0;
  static const IconData mailIcon = CupertinoIcons.mail_solid;
  static const double borderRadius = 12.0;
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 24.0;
}
