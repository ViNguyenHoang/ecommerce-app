import 'package:intl/intl.dart';

class Formatter {
  static formatPrice(num price) {
    final numberFormat = NumberFormat("###,###,###");

    return numberFormat.format(price);
  }

  static formatDateTime(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd/MM/yyyy hh:mm a");

    return dateFormat.format(localDate);
  }
}
