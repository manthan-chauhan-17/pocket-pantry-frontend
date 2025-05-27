import 'package:hive/hive.dart';

class HiveHelper {
  static addData(String boxName, dynamic value) {
    final box = Hive.box<String>(boxName);
    box.add(value);
  }

  static getData(String boxName) {
    final box = Hive.box<String>(boxName);
    return box.values.toList();
  }
}
