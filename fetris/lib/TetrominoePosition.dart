import 'main.dart';

class TetrominoePosition {
  final Tetrominoe tetrominoe;
  final double verticalOffsetCount;
  final double horizontalOffsetCount;

  TetrominoePosition(
      this.tetrominoe, this.verticalOffsetCount, this.horizontalOffsetCount);

  @override
  String toString() {
    return 'TetrominoePosition{tetrominoe: $tetrominoe, verticalOffsetCount: $verticalOffsetCount, horizontalOffsetCount: $horizontalOffsetCount}';
  }
}