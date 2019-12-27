import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePad extends StatelessWidget {
  final void Function() onLeftPressed;
  final void Function() onDownPressed;
  final void Function() onRightPressed;
  final void Function() onRotatePressed;

  GamePad(this.onLeftPressed, this.onDownPressed, this.onRightPressed,
      this.onRotatePressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GamePadButton("LEFT", onLeftPressed),
          GamePadButton("DOWN", onDownPressed),
          GamePadButton("RIGHT", onRightPressed),
          GamePadButton("TWIST", onRotatePressed),
        ],
      ),
    );
  }
}

class GamePadButton extends StatelessWidget {
  final void Function() _onButtonPressed;
  final String _text;

  GamePadButton(this._text, this._onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: _onButtonPressed,
        child: Center(
          child: Text(
            _text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
