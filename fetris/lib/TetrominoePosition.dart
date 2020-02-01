import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/TetrominoeBlock.dart';
import 'package:fetris/shapeMath.dart';

import 'Tetrominoe.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final List<Position> coordinates;
  final Rotation rotation;
  final Position pivot;
  final FetrisColorTheme theme;

  TetrominoePosition(
      this.tetrominoe, this.coordinates, this.rotation, this.pivot, this.theme);

  factory TetrominoePosition.fromOffset(
      Tetrominoe tetrominoe,
      int verticalOffset,
      int horizontalOffset,
      Rotation rotation,
      FetrisColorTheme theme) {
    return TetrominoePosition(
        tetrominoe,
        tetronimoeCoordinates(
            verticalOffset, horizontalOffset, tetrominoe, rotation),
        rotation,
        calculatePivot(tetrominoe, verticalOffset, horizontalOffset),
        theme);
  }

  factory TetrominoePosition.left(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x - 1, position.y);
    }).toList();
    Position newPivot = Position(old.pivot.x - 1, old.pivot.y);

    return TetrominoePosition(
        old.tetrominoe, newCoordinates, old.rotation, newPivot, old.theme);
  }

  factory TetrominoePosition.right(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x + 1, position.y);
    }).toList();
    Position newPivot = Position(old.pivot.x + 1, old.pivot.y);

    return TetrominoePosition(
        old.tetrominoe, newCoordinates, old.rotation, newPivot, old.theme);
  }

  factory TetrominoePosition.down(TetrominoePosition old) {
    List<Position> newCoordinates = old.coordinates.map((position) {
      return Position(position.x, position.y + 1);
    }).toList();
    Position newPivot = Position(old.pivot.x, old.pivot.y + 1);

    return TetrominoePosition(
        old.tetrominoe, newCoordinates, old.rotation, newPivot, old.theme);
  }

  factory TetrominoePosition.rotated(TetrominoePosition old) {
    Rotation newRotation = old.rotation;
    if (old.tetrominoe == Tetrominoe.STRAIGHT) {
      if (old.rotation == Rotation.NINETY) {
        newRotation = Rotation.ZERO;
      } else {
        newRotation = Rotation.NINETY;
      }
    } else {
      newRotation = nextRotation(old.rotation);
    }

    final newCoordinates = rotateCoordinates(old.coordinates, old.pivot);
    return TetrominoePosition(
        old.tetrominoe, newCoordinates, newRotation, old.pivot, old.theme);
  }

  bool collidesWith(Position otherCoordinate) {
    return _containsPoint(otherCoordinate.x, otherCoordinate.y);
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
      return TetrominoeBlock(theme[tetrominoe], position, tetrominoe);
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
