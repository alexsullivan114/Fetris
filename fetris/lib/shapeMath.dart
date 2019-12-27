import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

List<Position> tetronimoeCoordinates(int verticalOffsetCount, int horizontalOffsetCount,
    Tetrominoe tetrominoe, Rotation rotation) {
  List<Position> positions = [];
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return straightCoordinates(
          rotation, horizontalOffsetCount, verticalOffsetCount, tetrominoe);
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

List<Position> straightCoordinates(Rotation rotation, int horizontalOffsetCount,
    int verticalOffsetCount, Tetrominoe tetrominoe) {
  List<Position> positions = [];
  if (rotation == Rotation.NINETY) {
    for (int i = 0; i < tetrominoeHeight(tetrominoe); i++) {
      final position = Position(horizontalOffsetCount + i, verticalOffsetCount);
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
