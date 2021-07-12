String timeAgoSinceDate(DateTime dateString, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(dateString);

  if ((difference.inDays / 365).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} Y';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? '1 year' : 'Last year';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} M';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? '1 month' : 'Last month';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return '${(difference.inDays / 7).floor()} W';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour' : 'An hour';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute' : 'A minute';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds';
  } else {
    return 'Just now';
  }
}
String dateDifference(DateTime start,DateTime end ) {
  final difference = end.difference(start);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(difference.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(difference.inSeconds.remainder(60));
  return "${twoDigits(difference.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

}
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }

}