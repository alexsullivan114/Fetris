import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

class ShapesPainter extends CustomPainter {
  final List<TetrominoeBlock> _blocks;
  final double _blockSize;
  final int _horizontalCount;
  final int _verticalCount;
  final FetrisColorTheme _colorTheme;

  ShapesPainter(this._blocks, this._blockSize, this._horizontalCount,
      this._verticalCount, this._colorTheme);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, _blockSize, _horizontalCount, _verticalCount);
    _blocks.forEach((tetrominoeBlock) {
      _drawTetrominoeBlock(tetrominoeBlock, canvas, _blockSize);
    });
    _drawGrid(canvas, _blockSize, _horizontalCount, _verticalCount);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawBackground(
      Canvas canvas, double blockSize, int horizontalCount, int verticalCount) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..color = _colorTheme.grid;

    for (int j = 0; j < verticalCount; j++) {
      for (int i = 0; i < horizontalCount; i++) {
        Rect box =
            Rect.fromLTWH(blockSize * i, j * blockSize, blockSize, blockSize);
        canvas.drawRect(box, paint);
      }
    }
  }

  void _drawGrid(
      Canvas canvas, double blockSize, int horizontalCount, int verticalCount) {
    final outlinePaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = _colorTheme.gridLine;

    for (int j = 0; j < verticalCount; j++) {
      for (int i = 0; i < horizontalCount; i++) {
        Rect box =
            Rect.fromLTWH(blockSize * i, j * blockSize, blockSize, blockSize);
        canvas.drawRect(box, outlinePaint);
      }
    }
  }

  void _drawTetrominoeBlock(
      TetrominoeBlock block, Canvas canvas, double blockSize) {
    final shapePainter = Paint()..color = block.color;
    final position = block.position;
    final shapeRect = Rect.fromLTWH(
        position.x * blockSize, position.y * blockSize, blockSize, blockSize);
    canvas.drawRect(shapeRect, shapePainter);
  }
}
