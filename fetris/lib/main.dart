import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: TetrisBoard()),
    );
  }
}

class TetrisBoard extends StatefulWidget {
  @override
  _TetrisBoardState createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  List<TetrominoePosition> _tetrominoes = [
    TetrominoePosition(Tetrominoe.SQUARE, 0, 0)
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      setState(() {
        print("Woofers: " + _tetrominoes.toString());
        _tetrominoes = _tetrominoes.map((tetrominoePosition) {
          return TetrominoePosition(
              tetrominoePosition.tetrominoe,
              tetrominoePosition.verticalOffsetCount + 1,
              tetrominoePosition.horizontalOffsetCount);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building...");
    return CustomPaint(
      painter: ShapesPainter(_tetrominoes),
    );
  }
}

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

class ShapesPainter extends CustomPainter {
  final List<TetrominoePosition> _tetrominoes;

  ShapesPainter(this._tetrominoes);

  @override
  void paint(Canvas canvas, Size size) {
    double blockSize = size.width.floor() / 8;
    _tetrominoes.forEach((tetrominoePosition) {
      drawTetrominoes(
          tetrominoePosition.tetrominoe,
          canvas,
          blockSize,
          tetrominoePosition.verticalOffsetCount,
          tetrominoePosition.horizontalOffsetCount);
    });
    drawGrid(canvas, blockSize, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

void drawGrid(Canvas canvas, double blockSize, Size screenSize) {
  final paint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke
    ..color = Colors.yellow;
  paint.color = Colors.deepOrange;

  for (int j = 0; (j * blockSize) + blockSize < screenSize.height; j++) {
    for (int i = 0; i < blockSize; i++) {
      Rect box =
          Rect.fromLTWH(blockSize * i, j * blockSize, blockSize, blockSize);
      canvas.drawRect(box, paint);
    }
  }
}

void drawTetrominoes(Tetrominoe tetrominoe, Canvas canvas, double blockSize,
    double verticalOffset, double horizontalOffset) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      drawStraight(canvas, blockSize, verticalOffset, horizontalOffset);
      break;
    case Tetrominoe.SQUARE:
      drawSquare(canvas, blockSize, verticalOffset, horizontalOffset);
      break;
    case Tetrominoe.T:
      drawT(canvas, blockSize, verticalOffset, horizontalOffset);
      break;
    case Tetrominoe.L:
      drawL(canvas, blockSize, verticalOffset, horizontalOffset);
      break;
    case Tetrominoe.S:
      drawS(canvas, blockSize, verticalOffset, horizontalOffset);
      break;
  }
}

void drawStraight(Canvas canvas, double blockSize, double verticalOffset,
    double horizontalOffset) {
  final shapePainter = Paint()..color = Colors.cyanAccent;
  final shapeRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 5);
  canvas.drawRect(shapeRect, shapePainter);
}

void drawSquare(Canvas canvas, double blockSize, double verticalOffset,
    double horizontalOffset) {
  final shapePainter = Paint()..color = Colors.yellow;
  final shapeRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize * 2, blockSize * 2);
  canvas.drawRect(shapeRect, shapePainter);
}

void drawT(Canvas canvas, double blockSize, double verticalOffset,
    double horizontalOffset) {
  final shapePainter = Paint()..color = Colors.red;
  final topRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize * 3, blockSize * 1);
  canvas.drawRect(topRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize, blockSize, blockSize);
  canvas.drawRect(bottomRect, shapePainter);
}

void drawL(Canvas canvas, double blockSize, double verticalOffset,
    double horizontalOffset) {
  final shapePainter = Paint()..color = Colors.green;
  final lineRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 3);
  canvas.drawRect(lineRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize * 2, blockSize, blockSize);
  canvas.drawRect(bottomRect, shapePainter);
}

void drawS(Canvas canvas, double blockSize, double verticalOffset,
    double horizontalOffset) {
  final shapePainter = Paint()..color = Colors.blue;
  final topRect = Rect.fromLTWH(horizontalOffset * blockSize,
      verticalOffset * blockSize, blockSize, blockSize * 2);
  canvas.drawRect(topRect, shapePainter);
  final bottomRect = Rect.fromLTWH(horizontalOffset * blockSize + blockSize,
      verticalOffset * blockSize + blockSize, blockSize, blockSize * 2);
  canvas.drawRect(bottomRect, shapePainter);
}

enum Tetrominoe { STRAIGHT, SQUARE, T, L, S }
