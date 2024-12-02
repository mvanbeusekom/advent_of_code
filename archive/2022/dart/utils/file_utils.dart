import 'dart:io';

Future<List<String>> readAsLines(String filename) {
  return File(filename).readAsLines();
}