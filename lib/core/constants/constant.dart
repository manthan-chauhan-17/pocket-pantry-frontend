import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static const String appName = 'Pocket Pantry';
  static final String apiBaseUrl = dotenv.env['env'] == 'dev'
      ? 'http://192.168.0.101:3000/api/v1/'
      : 'https://pocket-pantry-backend-dnce.onrender.com/api/v1/';
  static const double generalPadding = 16.0;
  static const IconData mailIcon = CupertinoIcons.mail_solid;
}
