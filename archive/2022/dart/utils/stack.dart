class Stack<T> {
  final List<T> _innerList = [];

  /// Returns the amount of items on the stack.
  int get length => _innerList.length;

  /// Returns the top element on the stack without removing it.
  T peek() => _innerList.last;

  /// Removes the top item from the stack and returns it.
  T pop() => _innerList.removeLast();

  /// Adds a new item on top of the stack.
  void push(T value) => _innerList.add(value);
}
