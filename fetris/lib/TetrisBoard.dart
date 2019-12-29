import 'dart:async';

import 'package:fetris/GamePad.dart';
import 'package:flutter/material.dart';
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
    Timer.periodic(new Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _gameEngine = _gameEngine.tick();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Column(
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

class GameOverOverlay extends StatelessWidget {
  final int score;
  final void Function() replayClicked;

  const GameOverOverlay(this.score, this.replayClicked);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.8,
        child: Container(
            color: Colors.black,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Game Over",
                    style: TextStyle(color: Colors.white, fontSize: 48)),
                Text("Score: $score",
                    style: TextStyle(color: Colors.white, fontSize: 48)),
                IconButton(
                    icon: Icon(Icons.replay, color: Colors.white),
                    onPressed: replayClicked),
              ],
            ))));
  }
}
