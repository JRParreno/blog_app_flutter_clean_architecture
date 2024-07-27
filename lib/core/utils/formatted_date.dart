import 'package:intl/intl.dart';

String formattedBydMMMYYYY(DateTime dateTime) {
  return DateFormat('d MMM, yyyy').format(dateTime);
}
