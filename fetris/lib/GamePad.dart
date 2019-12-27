import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePad extends StatelessWidget {
  final void Function() onLeftPressed;
  final void Function() onDownPressed;
  final void Function() onRightPressed;

  GamePad(this.onLeftPressed, this.onDownPressed, this.onRightPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: onLeftPressed,
              child: Center(
                  child: Text(
                "LEFT",
                style: TextStyle(fontSize: 34),
              )),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: onDownPressed,
              child: Center(
                child: Text(
                  "DOWN",
                  style: TextStyle(fontSize: 34),
                ),
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: onRightPressed,
              child: Center(
                child: Text(
                  "RIGHT",
                  style: TextStyle(fontSize: 34),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
