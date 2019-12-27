import 'dart:ui';

import 'package:fetris/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

void drawTetrominoeBlock(TetrominoeBlock block, Canvas canvas,
    double blockSize) {
  final shapePainter = Paint()
    ..color = block.color;
  final position = block.position;
  final shapeRect = Rect.fromLTWH(
      position.x * blockSize, position.y * blockSize, blockSize, blockSize);
  canvas.drawRect(shapeRect, shapePainter);
}
