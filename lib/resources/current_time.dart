import 'package:intl/intl.dart';

String getCurrentTime() {
  final now = DateTime.now();
  return DateFormat.jm().format(now);
}
