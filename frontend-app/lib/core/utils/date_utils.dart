import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  static DateTime parse(String dateStr, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).parse(dateStr);
  }

  static String relative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 1) return '${diff.inDays} días atrás';
    if (diff.inHours > 1) return '${diff.inHours} horas atrás';
    if (diff.inMinutes > 1) return '${diff.inMinutes} minutos atrás';
    return 'hace un momento';
  }
}

