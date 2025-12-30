import 'package:intl/intl.dart';

/// A utility class for date and timestamp operations
/// Provides functions to convert between timestamps and dates,
/// calculate expiration days, and format dates in various ways.
class DateHelper {
  DateHelper._();

  // ================================================================
  // TIMESTAMP TO DATE CONVERSIONS
  // ================================================================

  /// Converts a timestamp (in seconds) to DateTime
  ///
  /// Example:
  /// ```dart
  /// final date = DateHelper.timestampToDateTime(1704067200);
  /// ```
  static DateTime timestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  /// Converts a timestamp (in milliseconds) to DateTime
  ///
  /// Example:
  /// ```dart
  /// final date = DateHelper.millisecondsTimestampToDateTime(1704067200000);
  /// ```
  static DateTime millisecondsTimestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Converts a timestamp string to DateTime
  /// Handles both seconds and milliseconds format
  ///
  /// Example:
  /// ```dart
  /// final date = DateHelper.stringTimestampToDateTime('1704067200');
  /// final date2 = DateHelper.stringTimestampToDateTime('1704067200000');
  /// ```
  static DateTime? stringTimestampToDateTime(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return null;

    try {
      final intValue = int.parse(timestamp);
      // If timestamp is in milliseconds (13+ digits), use milliseconds
      // Otherwise, assume seconds
      if (timestamp.length >= 13) {
        return DateTime.fromMillisecondsSinceEpoch(intValue);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(intValue * 1000);
      }
    } catch (e) {
      return null;
    }
  }

  // ================================================================
  // DATE TO TIMESTAMP CONVERSIONS
  // ================================================================

  /// Converts DateTime to timestamp (in seconds)
  ///
  /// Example:
  /// ```dart
  /// final timestamp = DateHelper.dateTimeToTimestamp(DateTime.now());
  /// ```
  static int dateTimeToTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  /// Converts DateTime to timestamp (in milliseconds)
  ///
  /// Example:
  /// ```dart
  /// final timestamp = DateHelper.dateTimeToMillisecondsTimestamp(DateTime.now());
  /// ```
  static int dateTimeToMillisecondsTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// Converts a date string to timestamp (in seconds)
  /// Supports various date formats
  ///
  /// Example:
  /// ```dart
  /// final timestamp = DateHelper.stringDateToTimestamp('2024-01-01');
  /// ```
  static int? stringDateToTimestamp(String? dateString, {String? format}) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      DateTime dateTime;
      if (format != null) {
        dateTime = DateFormat(format).parse(dateString);
      } else {
        // Try common formats
        dateTime = DateTime.parse(dateString);
      }
      return dateTimeToTimestamp(dateTime);
    } catch (e) {
      return null;
    }
  }

  // ================================================================
  // EXPIRATION CALCULATIONS
  // ================================================================

  /// Calculates the number of days until expiration from today
  /// Returns positive number if item hasn't expired, negative if expired
  ///
  /// Example:
  /// ```dart
  /// final days = DateHelper.daysUntilExpiration(DateTime(2024, 12, 31));
  /// // Returns: 30 (if today is Dec 1, 2024)
  /// ```
  static int daysUntilExpiration(DateTime expirationDate) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final expirationStart = DateTime(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
    );

    return expirationStart.difference(todayStart).inDays;
  }

  /// Calculates days until expiration from a timestamp
  ///
  /// Example:
  /// ```dart
  /// final days = DateHelper.daysUntilExpirationFromTimestamp(1704067200);
  /// ```
  static int daysUntilExpirationFromTimestamp(int timestamp) {
    final expirationDate = timestampToDateTime(timestamp);
    return daysUntilExpiration(expirationDate);
  }

  /// Calculates days until expiration from a timestamp string
  ///
  /// Example:
  /// ```dart
  /// final days = DateHelper.daysUntilExpirationFromString('1704067200');
  /// ```
  static int? daysUntilExpirationFromString(String? timestamp) {
    final dateTime = stringTimestampToDateTime(timestamp);
    if (dateTime == null) return null;
    return daysUntilExpiration(dateTime);
  }

  /// Checks if an item has expired
  ///
  /// Example:
  /// ```dart
  /// final isExpired = DateHelper.isExpired(DateTime(2024, 1, 1));
  /// ```
  static bool isExpired(DateTime expirationDate) {
    return daysUntilExpiration(expirationDate) < 0;
  }

  /// Checks if an item expires today
  ///
  /// Example:
  /// ```dart
  /// final expiresToday = DateHelper.expiresToday(DateTime.now());
  /// ```
  static bool expiresToday(DateTime expirationDate) {
    return daysUntilExpiration(expirationDate) == 0;
  }

  /// Checks if an item expires within a certain number of days
  ///
  /// Example:
  /// ```dart
  /// final expiresSoon = DateHelper.expiresWithinDays(DateTime(2024, 1, 5), 7);
  /// ```
  static bool expiresWithinDays(DateTime expirationDate, int days) {
    final daysUntil = daysUntilExpiration(expirationDate);
    return daysUntil >= 0 && daysUntil <= days;
  }

  // ================================================================
  // FORMATTED EXPIRATION STRINGS
  // ================================================================

  /// Gets a formatted expiration string (e.g., "1 Day", "2 Days", "1 Week", "3 Mos")
  /// Similar to what's shown in the UI
  ///
  /// Example:
  /// ```dart
  /// final text = DateHelper.getExpirationText(DateTime(2024, 1, 5));
  /// // Returns: "3 Days" (if today is Jan 2, 2024)
  /// ```
  static String getExpirationText(DateTime expirationDate) {
    final days = daysUntilExpiration(expirationDate);

    if (days < 0) {
      return 'Expired';
    } else if (days == 0) {
      return 'Today';
    } else if (days == 1) {
      return '1 Day';
    } else if (days < 7) {
      return '$days Days';
    } else if (days < 30) {
      final weeks = (days / 7).floor();
      if (weeks == 1) {
        return '1 Week';
      } else {
        return '$weeks Weeks';
      }
    } else if (days < 365) {
      final months = (days / 30).floor();
      if (months == 1) {
        return '1 Mo';
      } else {
        return '$months Mos';
      }
    } else {
      final years = (days / 365).floor();
      if (years == 1) {
        return '1 Year';
      } else {
        return '$years Years';
      }
    }
  }

  /// Gets expiration text from timestamp
  ///
  /// Example:
  /// ```dart
  /// final text = DateHelper.getExpirationTextFromTimestamp(1704067200);
  /// ```
  static String getExpirationTextFromTimestamp(int timestamp) {
    final expirationDate = timestampToDateTime(timestamp);
    return getExpirationText(expirationDate);
  }

  /// Gets expiration text from timestamp string
  ///
  /// Example:
  /// ```dart
  /// final text = DateHelper.getExpirationTextFromString('1704067200');
  /// ```
  static String? getExpirationTextFromString(String? timestamp) {
    final dateTime = stringTimestampToDateTime(timestamp);
    if (dateTime == null) return null;
    return getExpirationText(dateTime);
  }

  // ================================================================
  // DATE FORMATTING
  // ================================================================

  /// Formats DateTime to a readable date string
  ///
  /// Example:
  /// ```dart
  /// final formatted = DateHelper.formatDate(DateTime(2024, 1, 15));
  /// // Returns: "January 15, 2024" (default format)
  /// ```
  static String formatDate(
    DateTime dateTime, {
    String format = 'MMMM dd, yyyy',
  }) {
    return DateFormat(format).format(dateTime);
  }

  /// Formats DateTime to a short date string (MM/dd/yyyy)
  ///
  /// Example:
  /// ```dart
  /// final formatted = DateHelper.formatShortDate(DateTime(2024, 1, 15));
  /// // Returns: "01/15/2024"
  /// ```
  static String formatShortDate(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  /// Formats DateTime to ISO string (yyyy-MM-dd)
  ///
  /// Example:
  /// ```dart
  /// final formatted = DateHelper.formatISODate(DateTime(2024, 1, 15));
  /// // Returns: "2024-01-15"
  /// ```
  static String formatISODate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  /// Formats timestamp to a readable date string
  ///
  /// Example:
  /// ```dart
  /// final formatted = DateHelper.formatTimestamp(1704067200);
  /// ```
  static String formatTimestamp(
    int timestamp, {
    String format = 'MMMM dd, yyyy',
  }) {
    final dateTime = timestampToDateTime(timestamp);
    return formatDate(dateTime, format: format);
  }

  // ================================================================
  // RELATIVE TIME STRINGS
  // ================================================================

  /// Gets a relative time string (e.g., "2 days ago", "in 3 days")
  ///
  /// Example:
  /// ```dart
  /// final text = DateHelper.getRelativeTime(DateTime.now().add(Duration(days: 3)));
  /// // Returns: "in 3 days"
  /// ```
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'just now';
        } else if (difference.inMinutes == 1) {
          return 'in 1 minute';
        } else {
          return 'in ${difference.inMinutes} minutes';
        }
      } else if (difference.inHours == 1) {
        return 'in 1 hour';
      } else {
        return 'in ${difference.inHours} hours';
      }
    } else if (difference.inDays == 1) {
      return 'tomorrow';
    } else if (difference.inDays == -1) {
      return 'yesterday';
    } else if (difference.inDays > 0) {
      return 'in ${difference.inDays} days';
    } else {
      return '${difference.inDays.abs()} days ago';
    }
  }

  // ================================================================
  // DATE VALIDATION
  // ================================================================

  /// Validates if a date string is in a valid format
  ///
  /// Example:
  /// ```dart
  /// final isValid = DateHelper.isValidDate('2024-01-15');
  /// ```
  static bool isValidDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return false;

    try {
      DateTime.parse(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validates if a timestamp is valid
  ///
  /// Example:
  /// ```dart
  /// final isValid = DateHelper.isValidTimestamp(1704067200);
  /// ```
  static bool isValidTimestamp(int timestamp) {
    try {
      timestampToDateTime(timestamp);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ================================================================
  // DATE COMPARISON
  // ================================================================

  /// Compares two dates and returns the difference in days
  ///
  /// Example:
  /// ```dart
  /// final diff = DateHelper.compareDates(DateTime(2024, 1, 5), DateTime(2024, 1, 1));
  /// // Returns: 4
  /// ```
  static int compareDates(DateTime date1, DateTime date2) {
    final date1Start = DateTime(date1.year, date1.month, date1.day);
    final date2Start = DateTime(date2.year, date2.month, date2.day);
    return date1Start.difference(date2Start).inDays;
  }

  /// Gets the start of day (00:00:00) for a given date
  ///
  /// Example:
  /// ```dart
  /// final startOfDay = DateHelper.startOfDay(DateTime.now());
  /// ```
  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Gets the end of day (23:59:59) for a given date
  ///
  /// Example:
  /// ```dart
  /// final endOfDay = DateHelper.endOfDay(DateTime.now());
  /// ```
  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      23,
      59,
      59,
      999,
    );
  }
}
