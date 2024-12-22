/// Extension on [String] to provide a method for printing long strings in chunks.
extension PrintExtension on String? {
  /// Prints the string in chunks of a specified maximum length.
  ///
  /// If the string is not null, it splits the string into chunks of [maxLogSize] length
  /// and prints each chunk separately. If the string is null, it prints "String is null".
  void printLongString() {
    if (this != null) {
      const int maxLogSize = 1000; // The maximum length of each log line
      for (int i = 0; i <= this!.length / maxLogSize; i++) {
        int start = i * maxLogSize;
        int end = start + maxLogSize < this!.length
            ? start + maxLogSize
            : this!.length;
        print(this!.substring(start, end));
      }
    } else {
      print("String is null");
    }
  }
}
