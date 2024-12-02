import 'package:advent_of_code/puzzles/puzzles.dart';
import 'package:advent_of_code/src/puzzle.dart';
import 'package:args/args.dart';

List<Puzzle> puzzles = <Puzzle>[
  PuzzleOne(identifier: PuzzleIdentifier(year: 2024, day: 1)),
  PuzzleTwo(identifier: PuzzleIdentifier(year: 2024, day: 2)),
  PuzzleThree(identifier: PuzzleIdentifier(year: 2024, day: 3)),
];

ArgParser argumentParser = ArgParser()
  ..addFlag('today', abbr: 't')
  ..addFlag('all', abbr: 'a')
  ..addOption('day', abbr: 'd')
  ..addOption('year', abbr: 'y');

Future<void> main(List<String> arguments) async {
  final ArgResults results = argumentParser.parse(arguments);
  final List<Puzzle> puzzlesToSolve = <Puzzle>[];

  if (results.arguments.isEmpty || results.flag('today')) {
    final PuzzleIdentifier today =
        PuzzleIdentifier(year: DateTime.now().year, day: DateTime.now().day);
    puzzlesToSolve.addAll(
      puzzles.where((Puzzle puzzle) => puzzle.identifier == today).toList(),
    );
  } else if (results.option('year') != null) {
    final int year = int.parse(results.option('year')!);
    final int day = results.option('day') != null
        ? int.parse(results.option('day')!)
        : DateTime.now().day;
    final PuzzleIdentifier identifier = PuzzleIdentifier(year: year, day: day);
    puzzlesToSolve.addAll(
      puzzles
          .where((Puzzle puzzle) => puzzle.identifier == identifier)
          .toList(),
    );
  } else if (results.flag('all')) {
    puzzlesToSolve.addAll(puzzles);
  }

  for (final Puzzle puzzle in puzzlesToSolve) {
    await puzzle.load();
    await puzzle.solve();

    print(puzzle.answer);
  }
}
