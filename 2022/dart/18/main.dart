import 'dart:io';

const String inputFilename = 'input.txt';
List<Knot> knots = List.generate(10, (_) => Knot(x: 0, y: 0));
Set<String> visitedByTail = {};

Future<void> main() async {
  final File input = File(inputFilename);
  final List<String> lines = await input.readAsLines();
  final Iterable<Instruction> instructions =
      lines.map<Instruction>((String line) => Instruction.fromLine(line: line));

  instructions.forEach(
    (Instruction instruction) => executeInstruction(instruction),
  );

  print('Visited by tail: ${visitedByTail.length}');
}

void executeInstruction(Instruction instruction) {
  Direction direction = instruction.direction;
  for (int step = 0; step < instruction.steps; step++) {
    knots.first.move(direction);
    
    for (int i = 1; i < knots.length; i++) {
      knots[i].moveTo(knots[i - 1]);
    }

    visitedByTail.add(knots.last.toString());
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}

class Instruction {
  const Instruction({
    required this.direction,
    required this.steps,
  });

  factory Instruction.fromLine({required String line}) {
    final List<String> instruction = line.split(' ');
    Direction direction;

    switch (instruction[0]) {
      case 'U':
        direction = Direction.up;
        break;
      case 'D':
        direction = Direction.down;
        break;
      case 'L':
        direction = Direction.left;
        break;
      case 'R':
        direction = Direction.right;
        break;
      default:
        throw AssertionError(
            'Instruction "${instruction[0]}" could not be parsed.');
    }

    return Instruction(direction: direction, steps: int.parse(instruction[1]));
  }

  final Direction direction;
  final int steps;
}

class Knot {
  Knot({
    required this.x,
    required this.y,
  });

  factory Knot.copy(Knot other) {
    return Knot(x: other.x, y: other.y);
  }

  int x = 0;
  int y = 0;

  void move(Direction direction) {
    switch (direction) {
      case Direction.up:
        y++;
        break;
      case Direction.down:
        y--;
        break;
      case Direction.left:
        x--;
        break;
      case Direction.right:
        x++;
        break;
    }
  }

  void moveTo(Knot other) {
    if (isTouching(other)) {
      return;
    }

    int deltaX = x - other.x;
    int deltaY = y - other.y;

    x = deltaX == 0
        ? x
        : deltaX > 0
            ? x - 1
            : x + 1;
    y = deltaY == 0
        ? y
        : deltaY < 0
            ? y + 1
            : y - 1;
  }

  bool isTouching(Knot other) {
    return (x - other.x).abs() <= 1 && (y - other.y).abs() <= 1;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  bool operator ==(dynamic other) {
    return other is Knot && other.x == x && other.y == y;
  }

  @override
  String toString() {
    return '($x,$y)';
  }
}
