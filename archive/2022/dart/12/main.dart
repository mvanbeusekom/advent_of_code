import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final String data = await input.readAsString();
  
  for(int i = 0; i < data.length; i++) {
    final String fourCharacters = data.substring(i, i + 14);
    final bool different = allDifferent(fourCharacters);
    print('$fourCharacters - $different');

    if (different) {
      print('Start packet: ${data.substring(i, i + 14)} (found after processing ${i + 14} character.)');
      return;
    }
  }
}

bool allDifferent(String characters) {
  final List<int> codeUnits = characters.codeUnits;

  for(int codeUnit in codeUnits) {
    if (codeUnits.where((c) => c == codeUnit).length > 1) {
      return false;
    }
  }

  return true;
}