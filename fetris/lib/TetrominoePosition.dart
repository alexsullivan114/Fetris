import 'main.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final double verticalOffsetCount;
  final double horizontalOffsetCount;

  TetrominoePosition(
      this.tetrominoe, this.verticalOffsetCount, this.horizontalOffsetCount);

  bool collidesWith(TetrominoePosition other) {
    print("Comparing " +
        tetrominoe.toString() +
        " against " +
        other.tetrominoe.toString());
    Position otherTopPoint = other._topPoint();
    print("Other top point: " + otherTopPoint.toString());
    return _containsPoint(otherTopPoint.x, otherTopPoint.y);
  }

  Position _topPoint() {
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return Position(horizontalOffsetCount, verticalOffsetCount);
        break;
      case Tetrominoe.SQUARE:
        return Position(horizontalOffsetCount, verticalOffsetCount);
        break;
      case Tetrominoe.T:
        return Position(horizontalOffsetCount, verticalOffsetCount);
        break;
      case Tetrominoe.L:
        return Position(horizontalOffsetCount, verticalOffsetCount);
        break;
      case Tetrominoe.S:
        return Position(horizontalOffsetCount + 1, verticalOffsetCount);
        break;
    }

    return null;
  }

  bool _containsPoint(double x, double y) {
    double tetroY = verticalOffsetCount;
    double tetroX = horizontalOffsetCount;
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return tetroX == x && tetroY >= y && tetroY <= y + 3;
        break;
      case Tetrominoe.SQUARE:
        return (tetroX <= x && tetroX + 1 >= x) &&
            (tetroY >= y && tetroY + 1 <= y);
        break;
      case Tetrominoe.T:
        return ((tetroX <= x && tetroX + 2 <= x) && tetroY == y) ||
            (y == tetroY + 1 && x == tetroX + 1);
        break;
      case Tetrominoe.L:
        return (tetroX == x && tetroY <= y && tetroY + 2 >= y) ||
            (y == tetroY + 2 && x == tetroX + 1);
        break;
      case Tetrominoe.S:
        return (tetroX == x && tetroX <= y && tetroY + 1 >= y) ||
            (tetroY + 1 <= y && tetroY + 2 >= y && tetroX + 1 == x);
        break;
    }

    return false;
  }

  @override
  String toString() {
    return 'TetrominoePosition{tetrominoe: $tetrominoe, verticalOffsetCount: $verticalOffsetCount, horizontalOffsetCount: $horizontalOffsetCount}';
  }
}

class Position {
  final double x;
  final double y;

  Position(this.x, this.y);

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }
}
