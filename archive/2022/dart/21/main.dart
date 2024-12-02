import 'dart:io';

const bool enableLogging = true;
const String filename = 'input.txt';

List<Monkey> monkeys = [];

Future<void> main() async {
  final File input = File(filename);
  final List<String> lines = await input.readAsLines();

  for (int i = 0; i < lines.length; i = i + 7) {
    final Monkey monkey = Monkey.parse(lines.sublist(i, i + 6));
    monkeys.add(monkey);
  }

  for (int round = 1; round <= 20; round++) {
    monkeys.forEach((Monkey monkey) {
      monkey.play();
    });
  }

  final List<int> inspects =
      (monkeys.map((Monkey monkey) => monkey.inspects).toList()..sort())
          .reversed
          .take(2)
          .toList();

  print('Answer: ${inspects.first * inspects.last}');
}

enum Operation {
  add,
  multiply,
}

class Monkey {
  Monkey({
    required this.items,
    required this.operation,
    required this.worryLevelDivider,
    required this.receivingMonkeyIndexes,
    this.worryLevelOperand,
  });

  factory Monkey.parse(List<String> monkeyDefinition) {
    final List<int> items = _parseItems(monkeyDefinition[1]);
    final Operation operation = _parseOperation(monkeyDefinition[2]);
    final int? worryLevelOperand = _parseNumber(monkeyDefinition[2]);
    final int worryLevelDivider = _parseNumber(monkeyDefinition[3])!;
    final List<int> receivingMonkeyIndexes = [
      _parseNumber(monkeyDefinition[4])!,
      _parseNumber(monkeyDefinition[5])!,
    ];

    return Monkey(
      items: items,
      operation: operation,
      worryLevelOperand: worryLevelOperand,
      worryLevelDivider: worryLevelDivider,
      receivingMonkeyIndexes: receivingMonkeyIndexes,
    );
  }

  List<int> items;
  int inspects = 0;
  final Operation operation;
  final int worryLevelDivider;
  final int? worryLevelOperand;
  final List<int> receivingMonkeyIndexes;

  void catchItem(int item) {
    items.add(item);
  }

  void play() {
    items.forEach((int item) {
      inspects++;
      int updatedItem = _calculateWorryLevel(item) ~/ 3;

      Monkey receivingMonkey = (updatedItem % worryLevelDivider) == 0
          ? monkeys[receivingMonkeyIndexes[0]]
          : monkeys[receivingMonkeyIndexes[1]];

      receivingMonkey.catchItem(updatedItem);
    });

    items.clear();
  }

  int _calculateWorryLevel(int item) {
    switch (operation) {
      case Operation.add:
        return item + (worryLevelOperand ?? item);
      case Operation.multiply:
        return item * (worryLevelOperand ?? item);
      default:
        throw UnsupportedError('Operation ${operation.name} is not supported.');
    }
  }

  static List<int> _parseItems(String line) {
    final RegExp regex = RegExp('[0-9]+');
    return regex
        .allMatches(line)
        .map(
          (e) => int.parse(e[0]!),
        )
        .toList();
  }

  static Operation _parseOperation(String line) {
    if (line.contains('*')) {
      return Operation.multiply;
    }

    return Operation.add;
  }

  static int? _parseNumber(String line) {
    final RegExp regex = RegExp('[0-9]+');
    final Match? match = regex.firstMatch(line);

    return match != null ? int.parse(match[0]!) : null;
  }

  @override
  String toString() {
    return '''
Monkey: ${items.join(', ')}
  - Inspects: $inspects
  - Items: ${items.join(',')}
  - Operation: ${operation.name}
  - Worry operand: ${worryLevelOperand}
  - Worry divider: $worryLevelDivider
  - Monkey indexes: ${receivingMonkeyIndexes.join('|')}  
''';
  }
}

void log(String message) {
  if (!enableLogging) {
    return;
  }

  print(message);
}
