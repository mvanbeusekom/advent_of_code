class Coordinate {
  const Coordinate({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  Coordinate get up => Coordinate(x: x, y: y - 1);
  Coordinate get down => Coordinate(x: x, y: y + 1);
  Coordinate get left => Coordinate(x: x - 1, y: y);
  Coordinate get right => Coordinate(x: x + 1, y: y);

  @override
  int get hashCode => Object.hash(x, y);

  bool operator ==(covariant Coordinate other) {
    if (identical(this, other)) {
      return true;
    }

    return other.runtimeType == this.runtimeType &&
      other.x == this.x &&
      other.y == this.y;
  }

  @override
  String toString() => '($x, $y)';
}
