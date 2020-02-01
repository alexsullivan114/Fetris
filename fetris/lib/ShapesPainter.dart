import 'package:fetris/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

import 'drawShapes.dart';

class ShapesPainter extends CustomPainter {
  final List<TetrominoeBlock> _blocks;
  final double _blockSize;
  final int _horizontalCount;
  final int _verticalCount;

  ShapesPainter(this._blocks, this._blockSize, this._horizontalCount,
      this._verticalCount);

  @override
  void paint(Canvas canvas, Size size) {
    print("Size: " + size.toString());
    _blocks.forEach((tetrominoeBlock) {
      drawTetrominoeBlock(tetrominoeBlock, canvas, _blockSize);
    });
    drawGrid(canvas, _blockSize, _horizontalCount, _verticalCount);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawGrid(
      Canvas canvas, double blockSize, int horizontalCount, int verticalCount) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.deepOrange;

    for (int j = 0; j < verticalCount; j++) {
      for (int i = 0; i < horizontalCount; i++) {
        Rect box =
            Rect.fromLTWH(blockSize * i, j * blockSize, blockSize, blockSize);
        canvas.drawRect(box, paint);
      }
    }
  }
}
