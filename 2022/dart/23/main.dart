import '../utils/utils.dart';

const String filename = 'input.txt';

Future<void> main() async {
  List<List<int>> map = (await readAsLines(filename))
      .map<List<int>>((String line) => List.from(line.codeUnits))
      .toList();

  final Coordinate startCoordinate = findCoordinate(map, 'S'.codeUnitAt(0))!;
  final Coordinate targetCoordinate = findCoordinate(map, 'E'.codeUnitAt(0))!;

  map[startCoordinate.y][startCoordinate.x] = 'a'.codeUnitAt(0);
  map[targetCoordinate.y][targetCoordinate.x] = 'z'.codeUnitAt(0);

  final List<Node<Coordinate>> graph = convertToNodes(map);
  final Node start = findNode(graph, startCoordinate)!;
  
  Dijkstra.execute(graph, start);
  
  print('Amount: ${findNode(graph, targetCoordinate)!.weight}');
}

Coordinate? findCoordinate(List<List<int>> input, int codeUnit) {
  for (int j = 0; j < input.length; j++) {
    for (int i = 0; i < input.first.length; i++) {
      if (input[j][i] == codeUnit) {
        return Coordinate(x: i, y: j);
      }
    }
  }

  return null;
}

List<Node<Coordinate>> convertToNodes(List<List<int>> input) {
  final List<Node<Coordinate>> nodes = [];
  for (int j = 0; j < input.length; j++) {
    for (int i = 0; i < input[j].length; i++) {
      final Coordinate coordinate = Coordinate(x: i, y: j);
      nodes.add(Node<Coordinate>(value: coordinate));
    }
  }

  nodes.forEach((Node<Coordinate> node) {
    addNeighbor(input, node, findNode(nodes, node.value.up));
    addNeighbor(input, node, findNode(nodes, node.value.left));
    addNeighbor(input, node, findNode(nodes, node.value.down));
    addNeighbor(input, node, findNode(nodes, node.value.right));
  });

  return nodes;
}

void addNeighbor(List<List<int>> input, Node node, Node? neighbor) {
  if (neighbor == null ||
      input[neighbor.value.y][neighbor.value.x] -
              input[node.value.y][node.value.x] >
          1) {
    return;
  }

  node.addNeighbor(neighbor, 1);
}

Node<Coordinate>? findNode(
    List<Node<Coordinate>> nodes, Coordinate coordinate) {
  for (final Node<Coordinate> node in nodes) {
    if (node.value == coordinate) {
      return node;
    }
  }

  return null;
}
