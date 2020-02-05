import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

List<Position> tetronimoeCoordinates(int verticalOffsetCount,
    int horizontalOffsetCount, Tetrominoe tetrominoe, Rotation rotation) {
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
    case Tetrominoe.J:
      Position topRight = Position(horizontalOffsetCount + 1, verticalOffsetCount);
      Position middleRight =
          Position(horizontalOffsetCount + 1, verticalOffsetCount + 1);
      Position bottomRight =
          Position(horizontalOffsetCount + 1, verticalOffsetCount + 2);
      Position bottomLeft =
          Position(horizontalOffsetCount, verticalOffsetCount + 2);
      positions.add(topRight);
      positions.add(middleRight);
      positions.add(bottomRight);
      positions.add(bottomLeft);
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
    case Tetrominoe.Z:
      Position topLeft = Position(horizontalOffsetCount + 1, verticalOffsetCount);
      Position bottomLeft =
      Position(horizontalOffsetCount + 1, verticalOffsetCount + 1);
      Position topRight =
      Position(horizontalOffsetCount, verticalOffsetCount + 1);
      Position bottomRight =
      Position(horizontalOffsetCount, verticalOffsetCount + 2);

      positions.add(topRight);
      positions.add(bottomRight);
      positions.add(topLeft);
      positions.add(bottomLeft);
      break;
  }

  return positions;
}

Position calculatePivot(
    Tetrominoe tetrominoe, int verticalOffset, int horizontalOffset) {
  int x = 0;
  int y = 0;
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      x = horizontalOffset;
      y = verticalOffset + 2;
      break;
    case Tetrominoe.SQUARE:
      x = horizontalOffset;
      y = verticalOffset;
      break;
    case Tetrominoe.T:
      x = horizontalOffset + 1;
      y = verticalOffset;
      break;
    case Tetrominoe.L:
      x = horizontalOffset;
      y = verticalOffset + 1;
      break;
    case Tetrominoe.J:
      x = horizontalOffset;
      y = verticalOffset + 1;
      break;
    case Tetrominoe.S:
      x = horizontalOffset + 1;
      y = verticalOffset + 1;
      break;
    case Tetrominoe.Z:
      x = horizontalOffset + 1;
      y = verticalOffset + 1;
      break;
  }

  return Position(x, y);
}

List<Position> rotateCoordinates(List<Position> coordinates, Position pivot) {
  List<Position> normalized = coordinates.map((position) {
    return Position(position.x - pivot.x, position.y - pivot.y);
  }).toList();

  List<Position> rotated = normalized.map((position) {
    return Position(position.y, -1 * position.x);
  }).toList();

  List<Position> denormalized = rotated.map((position) {
    return Position(position.x + pivot.x, position.y + pivot.y);
  }).toList();

  return denormalized;
}
