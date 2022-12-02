import 'dart:io';

enum RockPaperScissors {
  rock,
  paper,
  scissors,
}

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();

  int totalScore = 0;

  for (String line in lines) {
    totalScore += processRound(line);
  }

  print('Total score: $totalScore');
}

int processRound(String round) {
  final List<String> turn = round.split(' ');

  int score = 0;
  if (turn[1] == 'Y') {
    score = turn[0] == 'A'
        ? 6
        : turn[0] == 'B'
            ? 3
            : 0;
    score += 2;
  } else if (turn[1] == 'X') {
    score = turn[0] == 'A'
        ? 3
        : turn[0] == 'B'
            ? 0
            : 6;
    score += 1;
  } else {
    score = turn[0] == 'A'
        ? 0
        : turn[0] == 'B'
            ? 6
            : 3;
    score += 3;
  }

  print('$round: $score');
  return score;
}
