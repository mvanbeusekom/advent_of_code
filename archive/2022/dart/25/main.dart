import '../utils/file_utils.dart';
import '../utils/primitive_wrapper.dart';

const String filename = '25/input.txt';

Future<void> main() async {
  final List<String> input = await readAsLines(filename);

  int sum = 0;
  int pairCount = 0;
  for (int index = 0; index < input.length; index += 3) {
    final Pair pair = Pair.fromStrings(input[index], input[index + 1]);
    pairCount++;

    final int compareResult =
        compare(pair.left, pair.right, PrimitiveWrapper(0));
 
    if (compareResult < 1) {
      sum += pairCount;
    }
  }

  print('Sum: $sum');
}

class Pair {
  const Pair({
    required this.left,
    required this.right,
  });

  factory Pair.fromStrings(String left, String right) {
    final List<Object> leftList = [];
    final List<Object> rightList = [];
    _parseString(
        list: leftList, input: left, currentIndex: PrimitiveWrapper(0));
    _parseString(
        list: rightList, input: right, currentIndex: PrimitiveWrapper(0));

    return Pair(
      left: leftList,
      right: rightList,
    );
  }

  final List<Object> left;

  final List<Object> right;

  static const _kComma = ',';
  static const _kOpenBracket = '[';
  static const _kCloseBracket = ']';

  static void _parseString({
    required List<Object> list,
    required String input,
    required PrimitiveWrapper<int> currentIndex,
  }) {
    if (currentIndex.value == input.length) {
      return;
    }

    String currentChar = input[currentIndex.value];
    if (currentChar == _kOpenBracket && currentIndex.value == 0) {
      currentIndex.value++;
    }

    while (currentIndex.value < input.length) {
      currentChar = input[currentIndex.value];
      currentIndex.value++;
      if (currentChar == _kCloseBracket) {
        return;
      } else if (currentChar == _kOpenBracket) {
        final List<Object> subList = [];
        list.add(subList);
        _parseString(
          list: subList,
          input: input,
          currentIndex: currentIndex,
        );
      } else if (currentChar == _kComma) {
        continue;
      } else {
        list.add(int.parse(currentChar));
      }
    }
  }
}

int compare(
  List<Object> left,
  List<Object> right,
  PrimitiveWrapper<int> compareResult,
) {
  if (left.isEmpty) {
    return right.isEmpty ? 0 : -1;
  } else if (left.length > right.length) {
    return 1;
  }

  for (int index = 0; index < left.length; index++) {
    final Object leftItem = left[index];
    final Object rightItem = right[index];
    if (leftItem is int && rightItem is int) {
      compareResult.value = leftItem > rightItem
          ? 1
          : leftItem == rightItem
              ? 0
              : -1;
    } else if (leftItem is List<Object> && rightItem is List<Object>) {
      compareResult.value = compare(leftItem, rightItem, compareResult);
    } else if (leftItem is List<Object> && rightItem is int) {
      compareResult.value = compare(leftItem, [rightItem], compareResult);
    } else if (leftItem is int && rightItem is List<Object>) {
      if (rightItem.isEmpty) {
        return 1;
      }

      compareResult.value = compare([leftItem], rightItem, compareResult);
    }

    if (compareResult.value != 0) {
      return compareResult.value;
    }
  }

  return compareResult.value == 0
      ? left.length < right.length
          ? -1
          : 0
      : compareResult.value;
}
