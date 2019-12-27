import 'package:fetris/TetrominoeBlock.dart';

import 'Tetrominoe.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final int verticalOffsetCount;
  final int horizontalOffsetCount;
  final Rotation rotation;

  TetrominoePosition(this.tetrominoe, this.verticalOffsetCount,
      this.horizontalOffsetCount, this.rotation);

  bool collidesWith(Position otherCoordinate) {
    return _containsPoint(otherCoordinate.x, otherCoordinate.y);
  }

  // Need to updates coordinates to include "spin" or rotation. Hopefully there's
  // some nice math formula I can use?
  List<Position> coordinates() {
    List<Position> positions = [];
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return straightCoordinates();
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

  List<Position> straightCoordinates() {
    List<Position> positions = [];
    if (rotation == Rotation.NINETY) {
      for (int i = 0; i < tetrominoeHeight(tetrominoe); i++) {
        final position =
            Position(horizontalOffsetCount + i, verticalOffsetCount);
        positions.add(position);
      }
    } else {
      for (int i = verticalOffsetCount;
          i < verticalOffsetCount + tetrominoeHeight(tetrominoe);
          i++) {
        Position position = Position(horizontalOffsetCount, i);
        positions.add(position);
      }
    }

    return positions;
  }

  bool _containsPoint(int x, int y) {
    int tetroY = verticalOffsetCount;
    int tetroX = horizontalOffsetCount;
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return tetroX == x && tetroY <= y && tetroY + 3 >= y;
        break;
      case Tetrominoe.SQUARE:
        return (tetroX <= x && tetroX + 1 >= x) &&
            (tetroY <= y && tetroY + 1 >= y);
        break;
      case Tetrominoe.T:
        return ((tetroX <= x && tetroX + 2 >= x) && tetroY == y) ||
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

  List<TetrominoeBlock> blocks() {
    return coordinates().map((position) {
      return TetrominoeBlock(tetrominoeColor(tetrominoe), position);
    }).toList();
  }

  int height() {
    if (rotation == Rotation.NINETY) {
      return tetrominoeWidth(tetrominoe);
    } else {
      return tetrominoeHeight(tetrominoe);
    }
  }

  int width() {
    if (rotation == Rotation.NINETY) {
      return tetrominoeHeight(tetrominoe);
    } else {
      return tetrominoeWidth(tetrominoe);
    }
  }

  TetrominoePosition rotated() {
    Rotation newRotation = rotation;
    if (tetrominoe == Tetrominoe.STRAIGHT) {
      if (rotation == Rotation.NINETY) {
        newRotation = Rotation.ZERO;
      } else {
        newRotation = Rotation.NINETY;
      }
    } else {
      newRotation = nextRotation(rotation);
    }

    return TetrominoePosition(
        tetrominoe, verticalOffsetCount, horizontalOffsetCount, newRotation);
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

enum Rotation { ZERO, NINETY, ONEEIGHTY }

Rotation nextRotation(Rotation rotation) {
  switch (rotation) {
    case Rotation.ZERO:
      return Rotation.NINETY;
      break;
    case Rotation.NINETY:
      return Rotation.ONEEIGHTY;
      break;
    case Rotation.ONEEIGHTY:
      return Rotation.ZERO;
      break;
  }

  return Rotation.ZERO;
}
