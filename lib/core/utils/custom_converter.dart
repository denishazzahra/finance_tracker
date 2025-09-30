import 'package:intl/intl.dart';

class CustomConverter {
  static String doubleToCurrency(double? num) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: "Rp",
      decimalDigits: 0,
    );
    if (num == null) return '0';
    return formatter.format(num);
  }

  static String datetimeToDisplay(DateTime? datetime) {
    if (datetime == null) {
      return '-';
    }
    final DateFormat formatter = DateFormat("E, MMMM d, y 'at' h.mm a");
    return formatter.format(datetime);
  }

  static String dateToDisplay(DateTime? datetime) {
    if (datetime == null) {
      return '-';
    }
    final DateFormat formatter = DateFormat("EEEE, MMMM d, y");
    return formatter.format(datetime);
  }
}
