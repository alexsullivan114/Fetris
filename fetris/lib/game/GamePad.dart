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
    return Stack(children: [
      Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: GestureDetector(
            onTap: onLeftPressed,
            child: Container(
              width: 100,
              color: Colors.transparent,
            ),
          )),
      Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: GestureDetector(
            onTap: onRightPressed,
            child: Container(
              width: 100,
              color: Colors.transparent,
            ),
          )),
      Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onDownPressed,
            child: Container(
              height: 100,
              color: Colors.transparent,
            ),
          )),
      Positioned(
          left: 100,
          bottom: 100,
          right: 100,
          top: 0,
          child: GestureDetector(
            onTap: onRotatePressed,
            child: Container(
              height: 100,
              color: Colors.transparent,
            ),
          ))
    ]);
  }
}
