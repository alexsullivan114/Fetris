import 'Tetrominoe.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final int verticalOffsetCount;
  final int horizontalOffsetCount;

  TetrominoePosition(
      this.tetrominoe, this.verticalOffsetCount, this.horizontalOffsetCount);

  bool collidesWith(TetrominoePosition other) {
    List<Position> otherCoordinates = other.coordinates();
    for (Position position in otherCoordinates) {
      if (_containsPoint(position.x, position.y)) {
        return true;
      }
    }

    return false;
  }

  List<Position> coordinates() {
    List<Position> positions = [];
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        for (int i = verticalOffsetCount;
            i < verticalOffsetCount + tetrominoeHeight(tetrominoe);
            i++) {
          Position position = Position(horizontalOffsetCount, i);
          positions.add(position);
        }
        break;
      case Tetrominoe.SQUARE:
        Position topLeft = Position(horizontalOffsetCount, verticalOffsetCount);
        Position topRight =
            Position(horizontalOffsetCount + 1, verticalOffsetCount);
        Position bottomLeft =
            Position(horizontalOffsetCount, verticalOffsetCount + 1);
        Position bottomRight =
            Position(horizontalOffsetCount + 1, verticalOffsetCount + 1);
        positions.add(topLeft);
        positions.add(topRight);
        positions.add(bottomLeft);
        positions.add(bottomRight);
        break;
      case Tetrominoe.T:
        Position topLeft = Position(horizontalOffsetCount, verticalOffsetCount);
        Position topMiddle =
            Position(horizontalOffsetCount + 1, verticalOffsetCount);
        Position topRight =
            Position(horizontalOffsetCount + 2, verticalOffsetCount);
        Position bottomMiddle =
            Position(horizontalOffsetCount + 1, verticalOffsetCount + 1);
        positions.add(topLeft);
        positions.add(topMiddle);
        positions.add(topRight);
        positions.add(bottomMiddle);
        break;
      case Tetrominoe.L:
        Position topLeft = Position(horizontalOffsetCount, verticalOffsetCount);
        Position middleLeft =
            Position(horizontalOffsetCount, verticalOffsetCount + 1);
        Position bottomLeft =
            Position(horizontalOffsetCount, verticalOffsetCount + 2);
        Position bottomRight =
            Position(horizontalOffsetCount + 1, verticalOffsetCount + 2);
        positions.add(topLeft);
        positions.add(middleLeft);
        positions.add(bottomLeft);
        positions.add(bottomRight);
        break;
      case Tetrominoe.S:
        Position topLeft = Position(horizontalOffsetCount, verticalOffsetCount);
        Position bottomLeft =
            Position(horizontalOffsetCount, verticalOffsetCount + 1);
        Position topRight =
            Position(horizontalOffsetCount + 1, verticalOffsetCount + 1);
        Position bottomRight =
            Position(horizontalOffsetCount + 1, verticalOffsetCount + 2);

        positions.add(topRight);
        positions.add(bottomRight);
        positions.add(topLeft);
        positions.add(bottomLeft);
        break;
    }

    return positions;
  }

  bool _containsPoint(int x, int y) {
    int tetroY = verticalOffsetCount;
    int tetroX = horizontalOffsetCount;
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return tetroX == x && tetroY >= y && tetroY <= y + 3;
        break;
      case Tetrominoe.SQUARE:
        return (tetroX <= x && tetroX + 1 >= x) &&
            (tetroY <= y && tetroY + 1 >= y);
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
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }
}
