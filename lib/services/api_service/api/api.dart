import 'dart:developer';

import 'package:pocket_pantry_frontend/services/api_service/retorfit/injection.dart';

class Api {
  static checkHealthApi() async {
    await restClient.healthcheck().then((value) {
      log('Healthcheck API response: $value', name: 'ApiService');
    }).catchError((error) {
      log('Error in healthcheck API: $error', name: 'ApiService');
    });
  }
}
