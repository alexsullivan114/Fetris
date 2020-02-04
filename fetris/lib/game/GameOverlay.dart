import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
