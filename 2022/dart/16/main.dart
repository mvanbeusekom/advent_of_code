import 'dart:io';

const String inputFile = 'input.txt';

Future<void> main() async {
  final File input = File(inputFile);
  final List<String> lines = await input.readAsLines();
  final List<List<Tree>> forest = parseForest(lines);

  int highestScenicScore = 0;

  for(int j = 0; j < forest.length; j++) {
    for(int i = 0; i < forest[j].length; i++) {
      int score = forest[j][i].scenicScore(forest);
      highestScenicScore = score > highestScenicScore ? score : highestScenicScore;
    }
  }
  
  print('Highest scenic score: ${highestScenicScore}');
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

  int scenicScore(List<List<Tree>> forest) {   
    int score = 0;

    // Check trees to the top.
    int visibleTreesTop = 0;
    for(int i = this.y - 1; i >= 0; i--) {
      visibleTreesTop++;
      if (forest[i][x].size >= size) {
        break;
      }
    }

    // Check trees to the left.
    int visibleTreesLeft = 0;
    for(int i = this.x - 1; i >= 0; i--) {
      visibleTreesLeft++;
      if (forest[y][i].size >= size) {
        break;
      }
    }

    // Check trees to the right.
    int visibleTreesRight = 0;
    for(int i = this.x + 1; i < forest[y].length; i++) {
      visibleTreesRight++;
      if (forest[y][i].size >= size) {
        break;
      }
    }

    // Check trees to the bottom.
    int visibleTreesBottom = 0;
    for(int i = this.y + 1; i < forest.length; i++) {
      visibleTreesBottom++;
      if (forest[i][x].size >= size) {
        break;
      }
    }

    return visibleTreesTop * visibleTreesLeft * visibleTreesRight * visibleTreesBottom;
  }
}
