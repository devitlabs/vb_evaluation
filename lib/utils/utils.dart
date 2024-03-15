import 'package:intl/intl.dart';

Map<String, dynamic> removeNullValues(Map<String, dynamic> json) {
  return json..removeWhere((key, value) => value == null);
}

String formatDate(DateTime dateTime) {
  // Define the format you want
  final formatter = DateFormat('dd-MM-yyyy');
  // Format the DateTime object using the formatter
  return formatter.format(dateTime);
}

