import 'package:equatable/equatable.dart';

import 'utils.dart';

/// A class that identifies the puzzle based on year, day and number.
///
/// Advent of Code releases a two part puzzle between 1st of December and 26th
/// of December every year (see https://adventofcode.com).
class PuzzleIdentifier extends Equatable {
  /// Creates a [PuzzleIdentifier].
  const PuzzleIdentifier({
    required this.year,
    required this.day,
  });

  /// Creates a [PuzzleIdentifier] based on todays date.
  PuzzleIdentifier.today()
      : year = DateTime.now().year,
        day = DateTime.now().day;

  /// The [year] in which the puzzle was released.
  final int year;

  /// The [day] in December the puzzle was released.
  final int day;

  @override
  List<Object?> get props => <Object?>[
        year,
        day,
      ];

  @override
  String toString() {
    return '$year - $day';
  }
}

/// Represents the answer for the puzzle matching the specified [identifier].
class Answer extends Equatable {
  /// Creates a [Answer].
  const Answer({
    required this.identifier,
    required this.partOne,
    required this.partTwo,
  });

  /// Creates an empty [Answer].
  const Answer.empty({
    required this.identifier,
  })  : partOne = 'n/a',
        partTwo = 'n/a';

  /// The identifier of the puzzle for which this is the answer.
  final PuzzleIdentifier identifier;

  /// The answer of the first part of the puzzle.
  final String partOne;

  /// The answer of the second part of the puzzle.
  final String partTwo;

  /// Creates a copy of this [Answer] updated with the supplied parameters.
  Answer copyWith({
    String? partOne,
    String? partTwo,
  }) =>
      Answer(
        identifier: identifier,
        partOne: partOne ?? this.partOne,
        partTwo: partTwo ?? this.partTwo,
      );

  @override
  List<Object?> get props => <Object?>[identifier, partOne, partTwo];

  @override
  String toString() {
    return '''
Answer for puzzle $identifier:
  1. $partOne
  2. $partTwo
''';
  }
}

/// Implementations contain the solution of the puzzle matching the specified
/// identifier.
abstract class Puzzle {
  /// Creates a [Puzzle].
  Puzzle({
    required this.identifier,
  }) : answer = Answer.empty(
          identifier: identifier,
        );

  /// The unique identifier for this puzzle.
  final PuzzleIdentifier identifier;

  /// The path pointing to the input file.
  String get inputFilePath =>
      'lib/puzzles/${identifier.year}/${identifier.day.toString().padLeft(2, '0')}/input.txt';

  /// The raw puzzle input as a [List<String>].
  late List<String> input;

  /// The answer of the puzzle
  Answer answer;

  /// Loads this input data from file into the [input] field.
  Future<void> load() async {
    input = await Utils.loadInput(inputFile: inputFilePath);
  }

  /// Contains the solution of the puzzle matching the identifier.
  Future<void> solve();
}
