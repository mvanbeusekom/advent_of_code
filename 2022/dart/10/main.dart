import 'dart:io';

/*
[P]     [L]         [T]            
[L]     [M] [G]     [G]     [S]    
[M]     [Q] [W]     [H] [R] [G]    
[N]     [F] [M]     [D] [V] [R] [N]
[W]     [G] [Q] [P] [J] [F] [M] [C]
[V] [H] [B] [F] [H] [M] [B] [H] [B]
[B] [Q] [D] [T] [T] [B] [N] [L] [D]
[H] [M] [N] [Z] [M] [C] [M] [P] [P]
 1   2   3   4   5   6   7   8   9 
*/

final List<List<String>> crates = [
  ['H', 'B', 'V', 'W', 'N', 'M', 'L', 'P'],
  ['M', 'Q', 'H'],
  ['N', 'D', 'B', 'G', 'F', 'Q', 'M', 'L'],
  ['Z', 'T', 'F', 'Q', 'M', 'W', 'G'],
  ['M', 'T', 'H', 'P'],
  ['C', 'B', 'M', 'J', 'D', 'H', 'G', 'T'],
  ['M', 'N', 'B', 'F', 'V', 'R'],
  ['P', 'L', 'H', 'M', 'R', 'G', 'S'],
  ['P', 'D', 'B', 'C', 'N'],
];

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();
  final List<Instruction> instructions = lines.map(
    (String line) {
      final List<String> splitInstruction = line.split(' ');
      return Instruction(
        amount: int.parse(splitInstruction[1]),
        from: int.parse(splitInstruction[3]) - 1,
        to: int.parse(splitInstruction[5]) - 1,
      );
    },
  ).toList();

  instructions.forEach((Instruction instruction) {
    final int start = crates[instruction.from].length - instruction.amount;
    final int end = crates[instruction.from].length;

    final List<String> cratesToMove =
        crates[instruction.from].sublist(start, end);
    crates[instruction.to].addAll(cratesToMove);
    crates[instruction.from].removeRange(start, end);
  });

  String output = '';
  crates.forEach((List<String> stack) => output += stack.last);
  print(output);
}

class Instruction {
  const Instruction({
    required this.amount,
    required this.from,
    required this.to,
  });

  final int amount;
  final int from;
  final int to;
}
