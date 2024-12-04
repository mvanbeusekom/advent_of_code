import '../../../src/puzzle.dart';
import '../../../src/utils.dart';

class PuzzleFour extends Puzzle {
  PuzzleFour({
    required super.identifier,
  });

  @override
  // TODO: implement inputFilePath
  String get inputFilePath => 'lib/puzzles/2024/04/input.txt';

  static const String pattern = 'XMAS';
  static const String reversedPattern = 'SAMX';

  @override
  Future<void> solve() async {
    final List<List<String>> charMatrix = Utils.toMatrix(input);

    partOne(charMatrix);
    partTwo(charMatrix);
  }

  void partOne(List<List<String>> charMatrix) {
    final int count = allMatches(charMatrix);

    answer = answer.copyWith(
      partOne: '$count',
    );
  }

  void partTwo(List<List<String>> charMatrix) {
    final int count = allXmasMatches(charMatrix);

    answer = answer.copyWith(
      partTwo: '$count',
    );
  }

  int allMatches(List<List<String>> charMatrix) {
    int count = 0;

    for (int lineIndex = 0; lineIndex < charMatrix.length; lineIndex++) {
      for (int charIndex = 0;
          charIndex < charMatrix[lineIndex].length;
          charIndex++) {
        if (charIndex < charMatrix[lineIndex].length - 3) {
          final String horizontal =
              '${charMatrix[lineIndex][charIndex]}${charMatrix[lineIndex][charIndex + 1]}${charMatrix[lineIndex][charIndex + 2]}${charMatrix[lineIndex][charIndex + 3]}';
          if (isMatch(horizontal)) {
            count++;
          }
        }

        // When 3 rows from the bottom we don't have to look vertically anymore.
        if (lineIndex >= charMatrix.length - 3) {
          continue;
        }

        final String char = charMatrix[lineIndex][charIndex];

        if (char != 'X' && char != 'S') {
          continue;
        }

        // Find all top - down results
        final String word =
            '$char${charMatrix[lineIndex + 1][charIndex]}${charMatrix[lineIndex + 2][charIndex]}${charMatrix[lineIndex + 3][charIndex]}';
        if (isMatch(word)) {
          count++;
        }

        // Find all right to left diagonal results,
        // Can only do that when on the 4th character from the left (note, index
        // is zero based).
        if (charIndex > 2) {
          final String word =
              '$char${charMatrix[lineIndex + 1][charIndex - 1]}${charMatrix[lineIndex + 2][charIndex - 2]}${charMatrix[lineIndex + 3][charIndex - 3]}';

          if (isMatch(word)) {
            count++;
          }
        }

        // Find all left to right diagonal results
        // Can only do that when on the forth last character from the right (
        // note, index is zero based).
        if (charIndex < charMatrix[lineIndex].length - 3) {
          final String word =
              '$char${charMatrix[lineIndex + 1][charIndex + 1]}${charMatrix[lineIndex + 2][charIndex + 2]}${charMatrix[lineIndex + 3][charIndex + 3]}';

          if (isMatch(word)) {
            count++;
          }
        }
      }
    }

    return count;
  }

  int allXmasMatches(List<List<String>> charMatrix) {
    int count = 0;

    for (int lineIndex = 0; lineIndex < charMatrix.length; lineIndex++) {
      for (int charIndex = 0;
          charIndex < charMatrix[lineIndex].length;
          charIndex++) {
        if (lineIndex < 1 || charIndex < 1) {
          continue;
        }

        if (lineIndex >= charMatrix.length - 1 ||
            charIndex >= charMatrix[lineIndex].length - 1) {
          continue;
        }

        final String char = charMatrix[lineIndex][charIndex];
        if (char != 'A') {
          continue;
        }

        final String leftToRight =
            '${charMatrix[lineIndex - 1][charIndex - 1]}$char${charMatrix[lineIndex + 1][charIndex + 1]}';
        final String rightToLeft =
            '${charMatrix[lineIndex - 1][charIndex + 1]}$char${charMatrix[lineIndex + 1][charIndex - 1]}';

        if (isXMatch(leftToRight) && isXMatch(rightToLeft)) {
          count++;
        }
      }
    }

    return count;
  }

  bool isMatch(String word) => word == pattern || word == reversedPattern;
  bool isXMatch(String word) => word == 'MAS' || word == 'SAM';
}
