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

  /// Converts the supplied string value into an iterable with each character.
  static Iterable<String> toStringIterable(String value) sync* {
    for (int i = 0; i < value.length; i++) {
      yield (value[i]);
    }
  }

  /// Converts the input list into a 2 dimensional string array.
  static List<List<String>> toMatrix(List<String> input) {
    return input
        .map((String line) => Utils.toStringIterable(line).toList())
        .toList();
  }
}
