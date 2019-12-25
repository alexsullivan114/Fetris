import 'dart:async';

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
      home: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return TetrisBoard(constraints);
      })),
    );
  }
}

class TetrisBoard extends StatefulWidget {
  final BoxConstraints _constraints;

  TetrisBoard(this._constraints);

  @override
  _TetrisBoardState createState() => _TetrisBoardState(_constraints);
}

class _TetrisBoardState extends State<TetrisBoard> {
  List<TetrominoePosition> _tetrominoes = [
    TetrominoePosition(Tetrominoe.L, 0, 0)
  ];

  final BoxConstraints _constraints;
  final double _blockSize;

  _TetrisBoardState(BoxConstraints _constraints)
      : _constraints = _constraints,
        _blockSize = _constraints.maxWidth.floor() / 8;

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _tetrominoes = _tetrominoes.map(_advance).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapesPainter(_tetrominoes, _blockSize),
    );
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {
    double totalVerticalBlockCount = _constraints.maxHeight.ceil() / _blockSize;
    int tetrominoeHeight = _tetrominoeHeight(tetrominoePosition.tetrominoe);
    int maxBlockCount = (totalVerticalBlockCount - tetrominoeHeight).floor();
    if (tetrominoePosition.verticalOffsetCount >= maxBlockCount) {
      return tetrominoePosition;
    } else {
      return TetrominoePosition(
          tetrominoePosition.tetrominoe,
          tetrominoePosition.verticalOffsetCount + 1,
          tetrominoePosition.horizontalOffsetCount);
    }
  }
}

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

int _tetrominoeHeight(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return 4;
      break;
    case Tetrominoe.SQUARE:
      return 2;
      break;
    case Tetrominoe.T:
      return 2;
      break;
    case Tetrominoe.L:
      return 3;
      break;
    case Tetrominoe.S:
      return 3;
      break;
  }
}
