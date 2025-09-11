class Format {
  String formatDateTime(DateTime date) {
    return "${date.month}월 ${date.day}일 ${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
  }
}