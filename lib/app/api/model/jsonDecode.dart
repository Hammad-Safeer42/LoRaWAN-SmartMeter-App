// ignore: file_names
dynamic decodeUnicode(dynamic key, dynamic value) {
  if (value is String) {
    return value.replaceAllMapped(
      RegExp(r'\\u(\d{4})'),
      (match) => String.fromCharCode(int.parse(match.group(1)!, radix: 16)),
    );
  }
  return value;
}
