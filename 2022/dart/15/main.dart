import 'dart:io';

const String inputFile = 'input.txt';

Future<void> main() async {
  final File input = File(inputFile);
  final List<String> lines = await input.readAsLines();
  final List<List<Tree>> forest = parseForest(lines);

  int amountVisible = forest.fold<int>(
    0, 
    (int previousValue, List<Tree> element) => previousValue + element.where((Tree tree) => tree.isVisible(forest)).length);
  
  print('Visible trees: ${amountVisible}');
}

List<List<Tree>> parseForest(List<String> lines) {
  final List<List<Tree>> forest = <List<Tree>>[];

  for (int j = 0; j < lines.length; j++) {
    final List<Tree> treeLine = <Tree>[];
    for (int i = 0; i < lines[j].length; i++) {
      treeLine.add(Tree(x: i, y: j, size: int.parse(lines[j][i])));
    }

    forest.add(treeLine);
  }

  return forest;
}

void printForest(List<List<Tree>> forest) {
  for (int j = 0; j < forest.length; j++) {
    print(forest[j].join());
  }
}

class Tree {
  const Tree({
    required this.x,
    required this.y,
    required this.size,
  });

  final int x;
  final int y;
  final int size;

  @override
  String toString() {
    return size.toString();
  }

  bool isVisible(List<List<Tree>> forest) {   
    bool visible = false;

    if (x == 0 || y == 0 || x == forest[y].length - 1 || y == forest.length - 1) {
      return true;
    }

    // Check trees to the top.
    for(int i = this.y - 1; i >= 0; i--) {
      Tree other = forest[i][x];
      if (other.size >= size) {
        visible = false;
        break;
      }

      visible = true;
    }

    if (visible) { return true; }

    // Check trees to the left.
    for(int i = this.x - 1; i >= 0; i--) {
      Tree other = forest[y][i];
      if (other.size >= size) {
        visible = false;
        break;
      }

      visible = true;
    }

    if (visible) { return true; }

    // Check trees to the right.
    for(int i = this.x + 1; i < forest[y].length; i++) {
      Tree other = forest[y][i];
      if (other.size >= size) {
        visible = false;
        break;
      }

      visible = true;
    }

    if (visible) { return true; }

    // Check trees to the bottom.
    for(int i = this.y + 1; i < forest.length; i++) {
      Tree other = forest[i][x];
      if (other.size >= size) {
        return false;
      }
    }

    return true;
  }
}
