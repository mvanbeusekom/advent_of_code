import 'dart:io';

const String inputFilename = 'input.txt';
Map<int, int> cycles = {};
int currentCycle = 0;
int registerX = 1;

Future<void> main() async {
  final File input = File(inputFilename);
  final List<String> lines = await input.readAsLines();
  final Iterable<Command> commands =
      lines.map<Command>((String line) => Command.fromLine(line: line));

  executeProgram(commands);

  int signalStrength = determineSignalStrength();
  print('Signal strength: $signalStrength');
}

void executeProgram(Iterable<Command> commands) {
  commands.forEach((Command command) {
    currentCycle++;
    if (command.instruction == Instruction.noop) {
      cycles[currentCycle] = registerX;
    }

    if (command.instruction == Instruction.addX) {
      cycles[currentCycle] = registerX;
      registerX += command.value;
      currentCycle++;
      cycles[currentCycle] = registerX;
    }
  });
}

int determineSignalStrength() {
  int signalStrength = 0;

  if (cycles.length < 20) {
    return signalStrength;
  }

  signalStrength = cycles[19]! * 20;

  for (int i = 60; i < cycles.length; i = i + 40) {
    signalStrength += cycles[i - 1]! * i;
  }

  return signalStrength;
}

enum Instruction {
  noop,
  addX,
}

class Command {
  const Command({
    required this.instruction,
    this.value = 0,
  });

  factory Command.fromLine({required String line}) {
    final List<String> command = line.split(' ');
    Instruction instruction;

    switch (command[0]) {
      case 'noop':
        instruction = Instruction.noop;
        break;
      case 'addx':
        instruction = Instruction.addX;
        break;
      default:
        throw AssertionError('Command "${command[0]}" could not be parsed.');
    }

    return Command(
        instruction: instruction,
        value: command.length > 1 ? int.parse(command[1]) : 0);
  }

  final Instruction instruction;
  final int value;
}
