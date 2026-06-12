import 'package:intl/intl.dart';

String formatDateTime(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) return '-';

  try {
    final date = DateTime.parse(dateTime).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    // Example: 12 Jun 2026, 02:00 PM
  } catch (e) {
    return dateTime;
  }
}