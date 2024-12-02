import '../01/main.dart';
import '../utils/utils.dart';

Future<void> main() async {
  //await first();
  await second();
}

Future<void> first() async {
  final List<List<int>> outputLevels = <List<int>>[];

  await forEachLine(
      inputFile: 'input.txt',
      run: (String line) {
        outputLevels.add(line.split(' ').map((e) => int.parse(e)).toList());
      });

  int unSafeLevels = 0;

  for (final List<int> levels in outputLevels) {
    final bool result = _isSafe(levels);
    if (!result) {
      unSafeLevels++;
    }
  }

  print('Total amount of safe levels: ${outputLevels.length - unSafeLevels}');
}

Future<void> second() async {
  final List<List<int>> outputLevels = <List<int>>[];

  await forEachLine(
      inputFile: 'input.txt',
      run: (String line) {
        outputLevels.add(line.split(' ').map((e) => int.parse(e)).toList());
      });

  int unSafeLevels = 0;

  for (final List<int> levels in outputLevels) {
    final bool result = _isSafe(levels);
    if (!result) {
      if (!_dampen(levels)) {
        unSafeLevels++;
      }
    }
  }

  print('Total amount of safe levels: ${outputLevels.length - unSafeLevels}');
}

bool _dampen(List<int> levels) {
  for (int i = 0; i < levels.length; i++) {
    final List<int> filteredLevels = List.from(levels)..removeAt(i);

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

    int firstLevel = levels[index];
    int secondLevel = levels[index + 1];
    int difference = (firstLevel - secondLevel).abs();
    int newDirection = firstLevel < secondLevel ? 1 : -1;

    bool isSafe = difference != 0 &&
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
