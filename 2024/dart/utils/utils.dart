import 'dart:io';

Future<void> forEachLine({
  required String inputFile,
  required void Function(String line) run,
}) async {
  final File input = File(inputFile);
  final List<String> lines = await input.readAsLines();

  for (final String line in lines) {
    run(line);
  }
}
