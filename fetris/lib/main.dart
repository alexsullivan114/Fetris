import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'TetrominoePosition.dart';
import 'drawShapes.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: ShapesPainter(_tetrominoes),
        );
      }
    );
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {}
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

enum Tetrominoe { STRAIGHT, SQUARE, T, L, S }
