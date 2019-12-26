import 'dart:ui';

import 'package:flutter/material.dart';

import 'Tetrominoe.dart';

void drawTetrominoes(Tetrominoe tetrominoe, Canvas canvas, double blockSize,
    int verticalOffsetCount, int horizontalOffsetCount) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      drawStraight(
          canvas, blockSize, verticalOffsetCount, horizontalOffsetCount);
      break;
    case Tetrominoe.SQUARE:
      drawSquare(canvas, blockSize, verticalOffsetCount, horizontalOffsetCount);
      break;
    case Tetrominoe.T:
      drawT(canvas, blockSize, verticalOffsetCount, horizontalOffsetCount);
      break;
    case Tetrominoe.L:
      drawL(canvas, blockSize, verticalOffsetCount, horizontalOffsetCount);
      break;
    case Tetrominoe.S:
      drawS(canvas, blockSize, verticalOffsetCount, horizontalOffsetCount);
      break;
  }
}

void drawStraight(Canvas canvas, double blockSize, int verticalOffset,
    int horizontalOffset) {
  final shapePainter = Paint()..color = Colors.cyanAccent;
  final shapeRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 4);
  canvas.drawRect(shapeRect, shapePainter);
}

void drawSquare(Canvas canvas, double blockSize, int verticalOffset,
    int horizontalOffset) {
  final shapePainter = Paint()..color = Colors.yellow;
  final shapeRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize * 2, blockSize * 2);
  canvas.drawRect(shapeRect, shapePainter);
}

void drawT(Canvas canvas, double blockSize, int verticalOffset,
    int horizontalOffset) {
  final shapePainter = Paint()..color = Colors.red;
  final topRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize * 3, blockSize * 1);
  canvas.drawRect(topRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize, blockSize, blockSize);
  canvas.drawRect(bottomRect, shapePainter);
}

void drawL(Canvas canvas, double blockSize, int verticalOffset,
    int horizontalOffset) {
  final shapePainter = Paint()..color = Colors.green;
  final lineRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 3);
  canvas.drawRect(lineRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize * 2, blockSize, blockSize);
  canvas.drawRect(bottomRect, shapePainter);
}

void drawS(Canvas canvas, double blockSize, int verticalOffset,
    int horizontalOffset) {
  final shapePainter = Paint()..color = Colors.blue;
  final topRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 2);
  canvas.drawRect(topRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize, blockSize, blockSize * 2);
  canvas.drawRect(bottomRect, shapePainter);
}
