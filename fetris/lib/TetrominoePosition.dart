import 'package:fetris/TetrominoeBlock.dart';
import 'package:fetris/shapeMath.dart';

import 'Tetrominoe.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final List<Position> coordinates;
  final Rotation rotation;

  TetrominoePosition(this.tetrominoe, this.coordinates, this.rotation);

  bool collidesWith(Position otherCoordinate) {
    return _containsPoint(otherCoordinate.x, otherCoordinate.y);
  }

  factory TetrominoePosition.fromOffset(Tetrominoe tetrominoe,
      int verticalOffsetCount, int horizontalOffset, Rotation rotation) {
    return TetrominoePosition(
        tetrominoe,
        tetronimoeCoordinates(
            verticalOffsetCount, horizontalOffset, tetrominoe, rotation),
        rotation);
  }

  factory TetrominoePosition.left(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x - 1, position.y);
    }).toList();

    return TetrominoePosition(old.tetrominoe, newCoordinates, old.rotation);
  }

  factory TetrominoePosition.right(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x + 1, position.y);
    }).toList();

    return TetrominoePosition(old.tetrominoe, newCoordinates, old.rotation);
  }

  factory TetrominoePosition.down(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x, position.y + 1);
    }).toList();

    return TetrominoePosition(old.tetrominoe, newCoordinates, old.rotation);
  }

  bool _containsPoint(int x, int y) {
    for (final value in coordinates) {
      if (value.x == x && value.y == y) {
        return true;
      }
    }

    return false;
  }

  List<TetrominoeBlock> blocks() {
    return coordinates.map((position) {
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


//
//    return TetrominoePosition(
//        tetrominoe, verticalOffsetCount, horizontalOffsetCount, newRotation);
  }

  @override
  String toString() {
    return 'TetrominoePosition{tetrominoe: $tetrominoe, coordinates: $coordinates, rotation: $rotation}';
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
