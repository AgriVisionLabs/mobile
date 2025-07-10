import 'package:intl/intl.dart';

String formatMessageTime(DateTime sentAt) {
  final now = DateTime.now();
  final isToday = sentAt.year == now.year &&
      sentAt.month == now.month &&
      sentAt.day == now.day;

  return isToday
      ? DateFormat.Hm().format(sentAt)       // hh:mm
      : DateFormat('dd MMM').format(sentAt); // 07 Jul
}