import 'dart:io';

final class Utils {
  /// Converts a list with string values to a list with integer values.
  static List<int> toIntList(List<String> input) {
    return input.map((String value) => int.parse(value)).toList();
  }

  /// Reads the contents from the specified [inputFile] and returns it as a list
  /// of string values.
  static Future<List<String>> loadInput({
    required String inputFile,
  }) {
    final File input = File(inputFile);
    return input.readAsLines();
  }
}
