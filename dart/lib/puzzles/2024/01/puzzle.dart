import '../../../src/puzzle.dart';

class PuzzleOne extends Puzzle {
  PuzzleOne({
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
    final (List<int>, List<int>) parsedInput = _parseInput();

    int distance = 0;
    for (int i = 0; i < parsedInput.$1.length; i++) {
      distance += (parsedInput.$1[i] - parsedInput.$2[i]).abs();
    }

    answer = answer.copyWith(partOne: distance.toString());
  }

  Future<void> _partTwo() async {
    final (List<int>, List<int>) parsedInput = _parseInput();

    int score = 0;
    for (final int location in parsedInput.$1) {
      final int count = parsedInput.$2
          .where((int rightLocation) => rightLocation == location)
          .length;
      score += location * count;
    }

    answer = answer.copyWith(partTwo: score.toString());
  }

  (List<int>, List<int>) _parseInput() {
    final List<int> left = <int>[];
    final List<int> right = <int>[];

    for (final String line in input) {
      final List<String> splitted = line.split('   ');
      left.add(int.parse(splitted[0]));
      right.add(int.parse(splitted[1]));
    }

    left.sort();
    right.sort();

    return (left, right);
  }
}
