import 'dart:io';

const String inputFilename = 'input.txt';
String crt = '';
int currentCycle = 0;
int registerX = 1;

Future<void> main() async {
  final File input = File(inputFilename);
  final List<String> lines = await input.readAsLines();
  final Iterable<Command> commands =
      lines.map<Command>((String line) => Command.fromLine(line: line));

  executeProgram(commands);

  for (int i = 0; i < crt.length; i = i + 40) {
    print(crt.substring(i, i + 40));
  }
}

void executeProgram(Iterable<Command> commands) {
  commands.forEach((Command command) {
    tick();
    
    if (command.instruction == Instruction.addX) {
      tick();
      registerX += command.value;
    }
  });
}

void tick() {
  currentCycle++;

  if (currentCycle >= registerX && currentCycle < registerX + 3) {
    crt += '#';
  } else {
    crt += '.';
  }

  if (currentCycle == 40) {
    currentCycle = 0;
  }
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
