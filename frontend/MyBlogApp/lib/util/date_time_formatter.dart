// Utility methods for DateTime formatting

final List<String> months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];

// Get date string (DD Mon YYYY) from DateTime
String getDate(DateTime dateTime) {
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;

  return '$day ${months[month - 1]} $year';
}
