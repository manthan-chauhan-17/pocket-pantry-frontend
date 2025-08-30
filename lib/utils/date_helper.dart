import 'package:intl/intl.dart';

class DateHelper {
  /// Convert a DateTime (from DatePicker) to UTC timestamp (ms since epoch)
  static int dateTimeToTimestamp(DateTime date) {
    return date.toUtc().millisecondsSinceEpoch;
  }

  /// Convert a timestamp (from backend) to human-readable string in local time
  static String timestampToString(
    int timestamp, {
    String format = 'dd MMM yyyy, hh:mm a',
  }) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).toLocal();
    return DateFormat(format).format(date);
  }

  /// Convert a DateTime to human-readable string (useful for showing picked date before saving)
  static String dateTimeToString(
    DateTime date, {
    String format = 'dd MMM yyyy, hh:mm a',
  }) {
    return DateFormat(format).format(date.toLocal());
  }

  /// Convert ISO 8601 string (e.g. "2025-01-01T01:07:00.000Z") to human-readable string
  static String isoStringToString(
    String isoString, {
    String format = 'dd MMM yyyy, hh:mm a',
  }) {
    final DateTime date = DateTime.parse(isoString).toLocal();
    return DateFormat(format).format(date);
  }
}
