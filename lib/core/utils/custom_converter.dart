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

  static String datetimeToDisplay(DateTime datetime) {
    final DateFormat formatter = DateFormat("E, d MMMM y 'at' h.mm a");
    return formatter.format(datetime);
  }
}
