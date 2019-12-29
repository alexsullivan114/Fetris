import 'dart:async';

import 'package:fetris/GamePad.dart';
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
    Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      setState(() {
        _gameEngine = _gameEngine.tick();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameEngine.gameState == GameState.DONE) {
      return Center(
          child: Text("YOU LOSE",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)));
    } else {
      return Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GamePad(() {
            setState(() {
              _gameEngine = _gameEngine.left();
            });
          }, () {
            setState(() {
              _gameEngine = _gameEngine.down();
            });
          }, () {
            setState(() {
              _gameEngine = _gameEngine.right();
            });
          }, () {
            setState(() {
              _gameEngine = _gameEngine.rotate();
            });
          }),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                _gameEngine.initialize(
                    constraints.maxWidth, constraints.maxHeight);
                return CustomPaint(
                  painter:
                      ShapesPainter(_gameEngine.blocks, _gameEngine.blockSize),
                );
              },
            ),
          ),
          Center(
              child: Text("Score: ${_gameEngine.score}",
                  style: TextStyle(fontSize: 45)))
        ],
      );
    }
  }
}
