import '../../../src/puzzle.dart';

class PuzzleThree extends Puzzle {
  PuzzleThree({
    required super.identifier,
  });

  String get _concatenated => input.join();
  final RegExp _mulExpression = RegExp(r'mul\(\d[0-9]{0,3},\d[0-9]{0,3}\)');
  final RegExp _digitExpression = RegExp(r'\d[0-9]{0,3}');
  final RegExp _doExpression = RegExp(r'do\(\)');
  final RegExp _donotExpression = RegExp(r"don't\(\)");

  @override
  Future<void> solve() {
    return Future.wait(<Future<void>>[
      _partOne(),
      _partTwo(),
    ]);
  }

  Future<void> _partOne() async {
    final Iterable<RegExpMatch> matches =
        _mulExpression.allMatches(_concatenated);

    int sum = 0;

    for (final RegExpMatch match in matches) {
      final String formula = match[0]!;
      final Iterable<RegExpMatch> digitMatches =
          _digitExpression.allMatches(formula);

      sum +=
          int.parse(digitMatches.first[0]!) * int.parse(digitMatches.last[0]!);
    }

    answer = answer.copyWith(partOne: sum.toString());
  }

  Future<void> _partTwo() async {
    final Iterable<RegExpMatch> matches =
        _mulExpression.allMatches(_concatenated);
    final List<int> doIndexes = findIndexes(_doExpression);
    final List<int> donotIndexes = findIndexes(_donotExpression);

    int sum = 0;
    for (final RegExpMatch match in matches) {
      final String formula = match[0]!;
      final Iterable<RegExpMatch> digitMatches =
          _digitExpression.allMatches(formula);

      if (shouldExecute(match.start, doIndexes, donotIndexes)) {
        final int first = int.parse(digitMatches.first[0]!);
        final int second = int.parse(digitMatches.last[0]!);

        sum += first * second;
      }
    }

    answer = answer.copyWith(partTwo: sum.toString());
  }

  List<int> findIndexes(RegExp expression) {
    return expression
        .allMatches(_concatenated)
        .map((RegExpMatch m) => m.start)
        .toList();
  }

  bool shouldExecute(int start, List<int> dos, List<int> donots) {
    final int doIndex = dos.lastWhere(
      (int i) => i < start,
      orElse: () => -1,
    );
    final int donotIndex = donots.lastWhere(
      (int i) => i < start,
      orElse: () => -1,
    );

    return donotIndex <= doIndex;
  }
}
