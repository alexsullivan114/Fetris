import 'dart:async';

import 'package:fetris/GamePad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'GameEngine.dart';
import 'GameOverlay.dart';
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
    final List<Widget> children = [
      Stack(
        children: [
          Column(
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    _gameEngine.initialize(
                        constraints.maxWidth, constraints.maxHeight);
                    return CustomPaint(
                      painter: ShapesPainter(
                          _gameEngine.blocks, _gameEngine.blockSize),
                    );
                  },
                ),
              ),
              Center(
                  child: Text("Score: ${_gameEngine.score}",
                      style: TextStyle(fontSize: 45)))
            ],
          ),
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
          })
        ],
      )
    ];
    if (_gameEngine.gameState == GameState.DONE) {
      children.add(GameOverOverlay(_gameEngine.score, () {
        setState(() {
          _gameEngine = _gameEngine.restart();
        });
      }));
    }
    return Stack(children: children);
  }
}
