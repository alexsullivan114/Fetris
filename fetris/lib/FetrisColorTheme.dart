import 'package:fetris/Tetrominoe.dart';
import 'package:flutter/material.dart';

class FetrisColorTheme {
  final Color _t;
  final Color _straight;
  final Color _square;
  final Color _l;
  final Color _s;

  operator [](Tetrominoe tetrominoe) {
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return _straight;
        break;
      case Tetrominoe.SQUARE:
        return _square;
        break;
      case Tetrominoe.T:
        return _t;
        break;
      case Tetrominoe.L:
        return _l;
        break;
      case Tetrominoe.S:
        return _s;
        break;
    }
  }

  FetrisColorTheme(this._t, this._straight, this._square, this._l, this._s);

  factory FetrisColorTheme.halloween() {
    return FetrisColorTheme(Color(0xFF000000), Color(0xFFff7930), Color(0xFFa73ae7),
        Color(0xFFf93636), Color(0xFFff7b0f));
  }

  factory FetrisColorTheme.grayScale() {
    return FetrisColorTheme(Color(0xFF000000), Color(0xFFCCCCCC), Color(0xFF999999),
        Color(0xFF666666), Color(0xFF333333));
  }
}
