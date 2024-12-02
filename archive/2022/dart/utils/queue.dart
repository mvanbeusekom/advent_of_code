class Queue<T> {
  final List<T> _innerList = [];

  int get length => _innerList.length;

  void enqueue(T value) => _innerList.add(value);

  T dequeue() => _innerList.removeAt(0);

  T peek() => _innerList[0];
}

class PriorityQueue<T> {
  PriorityQueue({
    required this.comparison,
  }) : _innerList = [];

  final int Function(T, T) comparison;

  final List<T> _innerList;

  int get length => _innerList.length;

  void enqueue(T value) {
    _innerList.add(value);
  }

  T dequeue() {
    _innerList.sort(comparison);
    return _innerList.removeAt(0);
  }
}