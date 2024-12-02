import 'dart:io';

const String inputFilename = 'input.txt';

Knot positionHead = Knot(x: 0, y: 0);
Knot positionTail = Knot(x: 0, y: 0);
Set<Knot> visitedByTail = {Knot(x: 0, y: 0)};

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
  for (int step = 0; step < instruction.steps; step++) {
    Knot head = positionHead.move(instruction.direction);
    Knot tail = positionTail;

    int diffX = head.x - positionTail.x;
    int diffY = head.y - positionTail.y;

    if (diffX.abs() > 1) {
      int posX = diffX.isNegative ? tail.x - 1 : tail.x + 1;
      tail = Knot(x: posX, y: head.y);
    }

    if (diffY.abs() > 1) {
      int posY = diffY.isNegative ? tail.y - 1 : tail.y + 1;
      tail = Knot(x: head.x, y: posY);
    }

    positionHead = head;
    positionTail = tail;

    if (!visitedByTail.contains(positionTail)) {
      visitedByTail.add(positionTail);
    }
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
      default:
        direction = Direction.right;
        break;
    }

    return Instruction(direction: direction, steps: int.parse(instruction[1]));
  }

  final Direction direction;
  final int steps;
}

class Knot {
  const Knot({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  Knot move(Direction direction) {
    switch (direction) {
      case Direction.up:
        return Knot(x: x, y: y - 1);
      case Direction.down:
        return Knot(x: x, y: y + 1);
      case Direction.left:
        return Knot(x: x - 1, y: y);
      case Direction.right:
        return Knot(x: x + 1, y: y);
    }
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
