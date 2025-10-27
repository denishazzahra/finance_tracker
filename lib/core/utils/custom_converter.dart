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

  static String timeToDisplay(DateTime? datetime) {
    if (datetime == null) {
      return '-';
    }
    final DateFormat formatter = DateFormat("h.mm a");
    return formatter.format(datetime);
  }

  static String dateToDisplay(DateTime? datetime) {
    if (datetime == null) {
      return '-';
    }
    final DateFormat formatter = DateFormat("EEEE, MMMM d, y");
    return formatter.format(datetime);
  }

  static int getMonthDiff(DateTime date1, DateTime date2) {
    int yearDiff = date2.year - date1.year;
    int monthDiff = date2.month - date1.month;
    return (yearDiff * 12) + monthDiff;
  }

  static DateTime nMonthDiff(int monthDiff, {DateTime? date}) {
    DateTime temp = date ?? DateTime.now();
    int newMonth = temp.month + monthDiff;
    int yearDiff = 0;
    if (newMonth > 12 || newMonth < 1) {
      /*
      ex 1: month = 2, monthDiff = 2, newMonth = 4->4, yearDiff = 0
      ex 2: month = 2, monthDiff = -2, newMonth = 0->12, yearDiff = -1
      ex 3: month = 10, monthDiff = 3, newMonth = 13->1, yearDiff = 1
      ex 4: month = 1, monthDiff = -13, newMonth = (-12)->1, yearDiff = -2
      ex 5: month = 12, monthDiff = 12, newMonth = 24->12, yearDiff = 1
      ex 6: month = 12, monthDiff = 13, newMonth = 25->1, yearDiff = 2
      */
      yearDiff = (newMonth - 1 / 12).floor();
      newMonth = (newMonth - 1) % 12 + 1;
    }
    final newDate = DateTime(temp.year + yearDiff, newMonth);
    return newDate;
  }
}
