import 'package:dio/dio.dart';

class ApiHelper {
  static List<MultipartFile> convertMapToMultipartList(
      Map<String, dynamic> data) {
    return data.entries.map((entry) {
      return MultipartFile.fromString(
        entry.key,
        filename: entry.value.toString(),
      );
    }).toList();
  }
}
