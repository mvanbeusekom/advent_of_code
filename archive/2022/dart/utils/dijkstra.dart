import 'queue.dart';

const int kMaxInt = 0x7fffffffffffffff;

class Node<T> {
  Node({
    required this.value,
    this.weight = kMaxInt,
    this.previousNode,
    this.visited = false,
    Map<Node, int>? neighbours,
  }) : _neighbors = neighbours ?? <Node, int>{};

  final T value;

  int weight;

  Node? previousNode;

  bool visited;

  Map<Node, int> _neighbors;

  Map<Node, int> get neighbors => _neighbors;

  bool get hasNeighbours => _neighbors.keys.isNotEmpty;

  void addNeighbor(Node node, int distance) {
    _neighbors[node] = distance;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(covariant Node<T> other) {
    if (identical(this, other)) {
      return true;
    }

    return other.runtimeType == this.runtimeType && other.value == this.value;
  }

  @override
  String toString() {
    return 'Value: $value, Weight: $weight, Visited: $visited';
  }
}

class Dijkstra {
  static void execute(List<Node> graph, Node start) {
    final PriorityQueue<Node> unvisited = PriorityQueue(
        comparison: (Node n1, Node n2) => n1.weight.compareTo(n2.weight));
    for (final Node node in graph) {
      if (node.value == start.value) {
        node.weight = 0;
        unvisited.enqueue(node);
      } else {
        node.weight = kMaxInt;
      }

      node.visited = false;
    }

    while (unvisited.length > 0) {
      final Node currentNode = unvisited.dequeue();

      if (currentNode.visited) {
        continue;
      }

      if (!currentNode.hasNeighbours) {
        currentNode.visited = true;
        continue;
      }

      for (final Node neighborNode in currentNode.neighbors.keys) {
        unvisited.enqueue(neighborNode);

        int tempWeight =
            currentNode.weight + currentNode.neighbors[neighborNode]!;
        if (tempWeight < neighborNode.weight) {
          neighborNode.weight = tempWeight;
          neighborNode.previousNode = currentNode;
        }
      }

      currentNode.visited = true;
    }
  }
}
