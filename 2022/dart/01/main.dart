import 'dart:io';

Future<void> main() async {
  final List<int> caloryTotals = <int>[];
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();

  int caloryCount = 0;
  for (String line in lines) {
    if (line.isEmpty) {
      caloryTotals.add(caloryCount);
      caloryCount = 0;
      continue;
    }

    caloryCount += int.parse(line);
  }

  caloryTotals.add(caloryCount);
  caloryTotals.sort();

  print(
      'Elf with most calories is: ${caloryTotals.last}');
}
