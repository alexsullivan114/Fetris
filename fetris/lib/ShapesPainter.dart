import 'package:fetris/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

import 'drawShapes.dart';

class ShapesPainter extends CustomPainter {
  final List<TetrominoeBlock> _blocks;
  final double _blockSize;

  ShapesPainter(this._blocks, this._blockSize);

  @override
  void paint(Canvas canvas, Size size) {
    _blocks.forEach((tetrominoeBlock) {
      drawTetrominoeBlock(tetrominoeBlock, canvas, _blockSize);
    });
    drawGrid(canvas, _blockSize, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawGrid(Canvas canvas, double blockSize, Size screenSize) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.deepOrange;

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
