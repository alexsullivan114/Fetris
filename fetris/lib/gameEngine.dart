import 'package:flutter/widgets.dart';

import 'TetrominoePosition.dart';
import 'main.dart';

class GameEngine {
  BoxConstraints _constraints;
  double blockSize;

  List<TetrominoePosition> tetrominoes = [];

  GameEngine(BoxConstraints _constraints) {
    TetrominoePosition active = TetrominoePosition(Tetrominoe.L, 0, 0);
    this._constraints = _constraints;
    this.blockSize = _constraints.maxWidth.floor() / 8;
    tetrominoes.add(active);
  }

  GameEngine tick() {
    TetrominoePosition active = tetrominoes[0];
    TetrominoePosition advancedActive = _advance(active);
    tetrominoes[0] = advancedActive;

    return this;
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {
    double totalVerticalBlockCount = _constraints.maxHeight.ceil() / blockSize;
    int height = tetrominoeHeight(tetrominoePosition.tetrominoe);
    int maxBlockCount = (totalVerticalBlockCount - height).floor();
    if (tetrominoePosition.verticalOffsetCount >= maxBlockCount) {
      return tetrominoePosition;
    } else {
      return TetrominoePosition(
          tetrominoePosition.tetrominoe,
          tetrominoePosition.verticalOffsetCount + 1,
          tetrominoePosition.horizontalOffsetCount);
    }
  }

  int tetrominoeHeight(Tetrominoe tetrominoe) {
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return 4;
        break;
      case Tetrominoe.SQUARE:
        return 2;
        break;
      case Tetrominoe.T:
        return 2;
        break;
      case Tetrominoe.L:
        return 3;
        break;
      case Tetrominoe.S:
        return 3;
        break;
    }

    return 0;
  }
}
