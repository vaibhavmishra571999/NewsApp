import 'package:intl/intl.dart';

String convertToLocaleTime(String universalTime) {
  final utcDateFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  final localDateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  final utcDateTime = utcDateFormat.parseUtc(universalTime);
  final localDateTime = utcDateTime.toLocal();

  return localDateFormat.format(localDateTime);
}
