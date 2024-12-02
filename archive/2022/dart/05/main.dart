import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();
  
  int sum = 0;
  for(int i = 0; i < lines.length; i += 3) {
    int foundChar = findSameChar(lines.sublist(i, i + 3));
    int priority = calculatePriority(foundChar);
    sum += priority;
  }

  print('Sum: $sum');

}

int findSameChar(List<String> lines) {
  assert(lines.length != 3, 'Expect exactly three lines.');

  for(int codeUnit in lines[0].codeUnits) { 
    String char = Utf8Decoder().convert([codeUnit]);
    if (lines[1].contains(char) && lines[2].contains(char)) {
      return codeUnit;
    }
  }

  return 0;
}

int calculatePriority(int codeUnit) {
  return (codeUnit >= 41 && codeUnit < 91) 
      ? codeUnit - 38
      : codeUnit - 96;
}