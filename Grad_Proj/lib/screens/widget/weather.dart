import 'package:intl/intl.dart';

String getDayName(String? day) {
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime date = DateTime.parse(day!);
  if (date == today) {
    return 'Today';
  }

  String dayName = DateFormat('EEEE').format(date);
  return dayName;
}

String getImage(double? precipitation) {
  if (precipitation == 0) {
    return 'assets/images/sunny.png';
  } else if (precipitation==3) {
   return 'assets/images/partly-cloudy.png';
  } else if (precipitation ==48) {
    return 'assets/images/cloudy.png';
  } else if (precipitation ==95) {
    return 'assets/images/rain.png';
  } else {
    return 'assets/images/ruiny.png';
  }
}
