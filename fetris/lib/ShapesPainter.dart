import 'package:flutter/material.dart';

import 'TetrominoePosition.dart';
import 'drawShapes.dart';

class ShapesPainter extends CustomPainter {
  final List<TetrominoePosition> _tetrominoes;
  final double _blockSize;

  ShapesPainter(this._tetrominoes, this._blockSize);

  @override
  void paint(Canvas canvas, Size size) {
    _tetrominoes.forEach((tetrominoePosition) {
      drawTetrominoes(
          tetrominoePosition.tetrominoe,
          canvas,
          _blockSize,
          tetrominoePosition.verticalOffsetCount,
          tetrominoePosition.horizontalOffsetCount);
    });
    drawGrid(canvas, _blockSize, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawGrid(Canvas canvas, double blockSize, Size screenSize) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.yellow;
    paint.color = Colors.deepOrange;

    int verticalCount = (screenSize.height / blockSize).floor();
    for (int j = 0; j < verticalCount; j++) {
      for (int i = 0; i < blockSize; i++) {
        Rect box =
            Rect.fromLTWH(blockSize * i, j * blockSize, blockSize, blockSize);
        canvas.drawRect(box, paint);
      }
    }
  }
}
