import 'package:intl/intl.dart';

class DateFormatter {
  // Format from a DateTime object to "yyyy-MM-dd"
  static String formatToYYYYMMDD(DateTime? date) {
    if (date == null) {
      return '';
    }
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // Parse a string in "yyyy-MM-dd" format to a DateTime object
  static DateTime? parseFromYYYYMMDD(String dateString) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.tryParse(dateString);
  }
}
