String extractBetweenPipes(String input) {
  int startIndex = input.indexOf('|');
  if (startIndex == -1) {
    return "";
  }
  int endIndex = input.indexOf('|', startIndex + 1);
  if (endIndex == -1) {
    return "";
  }
  String result = input.substring(startIndex + 1, endIndex);
  return result;
}
