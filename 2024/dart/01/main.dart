import '../utils/utils.dart';

Future<void> main() async {
  await first();
  await second();
}

Future<void> first() async {
  final List<int> left = <int>[];
  final List<int> right = <int>[];

  await forEachLine(
      inputFile: 'input.txt',
      run: (String line) {
        final List<String> splitted = line.split('   ');
        left.add(int.parse(splitted[0]));
        right.add(int.parse(splitted[1]));
      });

  left.sort();
  right.sort();

  int distance = 0;
  for (int i = 0; i < left.length; i++) {
    distance += (left[i] - right[i]).abs();
  }

  print('Total difference in location: $distance');
}

Future<void> second() async {
  final List<int> left = <int>[];
  final List<int> right = <int>[];

  await forEachLine(
      inputFile: 'input.txt',
      run: (String line) {
        final List<String> splitted = line.split('   ');
        left.add(int.parse(splitted[0]));
        right.add(int.parse(splitted[1]));
      });

  left.sort();
  right.sort();

  int score = 0;
  for (final int location in left) {
    final int count =
        right.where((int rightLocation) => rightLocation == location).length;
    score += location * count;
  }

  print('Total similarity score: $score');
}
