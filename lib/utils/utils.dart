class Utils {
  static String shortenText(String text, {int maxLength = 22}) {
    if (text.length >= maxLength) {
      text = "${text.substring(0, maxLength)}...";
    }
    return text;
  }

  static String formatDate(String dateString) {
    if (dateString == "") return "";

    final dateTime = DateTime.parse(dateString).toLocal();

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');

    return '$day/$month/$year - $hour:$minute:$second';
  }
}
