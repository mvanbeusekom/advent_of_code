import '../../../src/puzzle.dart';
import '../../../src/utils.dart';

class PuzzleTwo extends Puzzle {
  PuzzleTwo({
    required super.identifier,
  });

  @override
  Future<void> solve() {
    return Future.wait(<Future<void>>[
      _partOne(),
      _partTwo(),
    ]);
  }

  Future<void> _partOne() async {
    final List<List<int>> parsedInput =
        input.map((String value) => Utils.toIntList(value.split(' '))).toList();

    int unSafeLevels = 0;

    for (final List<int> levels in parsedInput) {
      final bool result = _isSafe(levels);
      if (!result) {
        unSafeLevels++;
      }
    }

    answer = answer.copyWith(partOne: '${parsedInput.length - unSafeLevels}');
  }

  Future<void> _partTwo() async {
    final List<List<int>> parsedInput =
        input.map((String value) => Utils.toIntList(value.split(' '))).toList();

    int unSafeLevels = 0;

    for (final List<int> levels in parsedInput) {
      final bool result = _isSafe(levels);
      if (!result) {
        if (!_dampen(levels)) {
          unSafeLevels++;
        }
      }
    }

    answer = answer.copyWith(partTwo: '${parsedInput.length - unSafeLevels}');
  }

  bool _dampen(List<int> levels) {
    for (int i = 0; i < levels.length; i++) {
      final List<int> filteredLevels = List<int>.from(levels)..removeAt(i);

      if (_isSafe(filteredLevels)) {
        return true;
      }
    }

    return false;
  }

  bool _isSafe(List<int> levels) {
    int direction = 0;
    int index = 0;

    while (true) {
      if (index + 1 == levels.length) {
        break;
      }

      final int firstLevel = levels[index];
      final int secondLevel = levels[index + 1];
      final int difference = (firstLevel - secondLevel).abs();
      final int newDirection = firstLevel < secondLevel ? 1 : -1;

      final bool isSafe = difference != 0 &&
          difference <= 3 &&
          (direction == 0 || direction == newDirection);

      direction = newDirection;

      if (!isSafe) {
        return false;
      }

      index++;
    }

    return true;
  }
}
