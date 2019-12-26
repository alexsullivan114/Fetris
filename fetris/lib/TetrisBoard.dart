import 'dart:async';

import 'package:flutter/widgets.dart';

import 'ShapesPainter.dart';
import 'GameEngine.dart';

class TetrisBoard extends StatefulWidget {
  final BoxConstraints _constraints;

  TetrisBoard(this._constraints);

  @override
  _TetrisBoardState createState() => _TetrisBoardState(_constraints);
}

class _TetrisBoardState extends State<TetrisBoard> {
  GameEngine _gameEngine;

  _TetrisBoardState(BoxConstraints _constraints)
      : _gameEngine = GameEngine(_constraints);

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
    return CustomPaint(
      painter: ShapesPainter(_gameEngine.tetrominoes, _gameEngine.blockSize),
    );
  }
}
