import '../../../src/puzzle.dart';

class PuzzleThree extends Puzzle {
  PuzzleThree({
    required super.identifier,
  });

  @override
  Future<void> solve() {
    return Future.wait(<Future<void>>[
      _partOne(),
      _partTwo(),
    ]);
  }

  Future<void> _partOne() async {}

  Future<void> _partTwo() async {}
}
