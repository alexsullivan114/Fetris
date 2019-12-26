import 'dart:async';

import 'package:flutter/widgets.dart';

import 'GameEngine.dart';
import 'ShapesPainter.dart';

class TetrisBoard extends StatefulWidget {
  @override
  _TetrisBoardState createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  GameEngine _gameEngine;

  _TetrisBoardState() {
    _gameEngine = GameEngine();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _gameEngine = _gameEngine.tick();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _gameEngine.initialize(constraints.maxWidth, constraints.maxHeight);
        return CustomPaint(
          painter:
              ShapesPainter(_gameEngine.tetrominoes, _gameEngine.blockSize),
        );
      },
    );
  }
}
