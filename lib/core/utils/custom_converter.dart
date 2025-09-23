import 'package:intl/intl.dart';

class CustomConverter {
  static String doubleToCurrency(double num) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: "Rp",
      decimalDigits: 0,
    );
    return formatter.format(num);
  }
}
