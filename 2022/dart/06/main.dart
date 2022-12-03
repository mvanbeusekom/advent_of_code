import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();
  final Map<String, String> splitLines = parse(lines);
  final List<int> foundSymbols = findSameChar(splitLines);

  int sum = 0;
  foundSymbols.forEach((element) { 
    int priority = (element >= 41 && element < 91) 
      ? element - 38
      : element - 96;
    
    print('${Utf8Decoder().convert([element])}: $priority');

    sum += priority;
  });

  print('Sum: $sum');

}

Map<String, String> parse(List<String> lines) {
  final Map<String, String> splitLines = {};

  for(String line in lines) {
    final int halfIndex = line.length ~/ 2;
    splitLines[line.substring(0, halfIndex)] = line.substring(halfIndex, line.length);
  }

  return splitLines;
} 

List<int> findSameChar(Map<String, String> input) {
  List<int> foundSymbols = [];
  input.forEach((key, value) {
    for (int codeUnit in key.codeUnits) {
      if (value.codeUnits.contains(codeUnit)) {
        foundSymbols.add(codeUnit);
        return;
      }
    }
   });

   return foundSymbols;
}