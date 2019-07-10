List<String> monthsNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec'
];

String getFormattedDate(int dueDate) {
  final date = DateTime.fromMillisecondsSinceEpoch(dueDate);
  return '${monthsNames[date.month - 1]}  ${date.day}';
}
