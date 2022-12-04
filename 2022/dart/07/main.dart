import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();
  final List<Pair> pairs = lines.map((e) => Pair.fromString(pair: e),).toList();

  print('Count overlap: ${pairs.where((element) => element.overlap()).length}');
}

class Pair {
  const Pair({
    required this.rangeOne,
    required this.rangeTwo,
  });

  factory Pair.fromString({required String pair}) {
    final List<String> splitPair = pair.split(',');
    return Pair(
      rangeOne: Range.fromString(range: splitPair[0]),
      rangeTwo: Range.fromString(range: splitPair[1]),
    );
  }

  final Range rangeOne;
  final Range rangeTwo;

  bool overlap() {
    if (rangeOne.min <= rangeTwo.min && rangeOne.max >= rangeTwo.min) {
      return true;
    } else if (rangeTwo.min <= rangeOne.min && rangeTwo.max >= rangeOne.min) {
      return true;
    }

    return false;
  }
}

class Range {
  const Range({
    required this.min,
    required this.max,
  });

  factory Range.fromString({required String range}) {
    final List<String> splitRange = range.split('-');
    return Range(min: int.parse(splitRange[0]), max: int.parse(splitRange[1]));
  }

  final int min;
  final int max;
}