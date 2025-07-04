int calculateDaysDifference(DateTime apiDateString) {
  DateTime today = DateTime.now();

  DateTime targetOnly =
      DateTime(apiDateString.year, apiDateString.month, apiDateString.day);
  DateTime todayOnly = DateTime(today.year, today.month, today.day);

  return targetOnly.difference(todayOnly).inDays;
}