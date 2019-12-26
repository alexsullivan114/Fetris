import 'dart:math';

import 'package:flutter/widgets.dart';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

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
    if (active == advancedActive) {
      TetrominoePosition nextActive = _generateNewTetrominoe();
      tetrominoes.insert(0, nextActive);
      return this;
    }
    for (TetrominoePosition existing in tetrominoes.sublist(1)) {
      if (advancedActive.collidesWith(existing)) {
        TetrominoePosition nextActive = _generateNewTetrominoe();
        tetrominoes.insert(0, nextActive);
        return this;
      }
    }
    tetrominoes[0] = advancedActive;

    return this;
  }

  TetrominoePosition _generateNewTetrominoe() {
    Tetrominoe nextTetrominoe = _randomTetrominoe();
    int horizontalMax =
        Random().nextInt((_constraints.maxWidth / blockSize).floor()) -
            _tetrominoeWidth(nextTetrominoe);
    int horizontal = max(0, horizontalMax);
    return TetrominoePosition(nextTetrominoe, 0, horizontal);
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {
    int totalVerticalBlockCount = (_constraints.maxHeight / blockSize).floor();
    int height = tetrominoeHeight(tetrominoePosition.tetrominoe);
    int maxBlockCount = totalVerticalBlockCount - height;
    if (tetrominoePosition.verticalOffsetCount >= maxBlockCount) {
      return tetrominoePosition;
    } else {
      return TetrominoePosition(
          tetrominoePosition.tetrominoe,
          tetrominoePosition.verticalOffsetCount + 1,
          tetrominoePosition.horizontalOffsetCount);
    }
  }

  Tetrominoe _randomTetrominoe() {
    int random = Random().nextInt(Tetrominoe.values.length);
    return Tetrominoe.values[random];
  }

  int _tetrominoeWidth(Tetrominoe tetrominoe) {
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return 1;
        break;
      case Tetrominoe.SQUARE:
        return 2;
        break;
      case Tetrominoe.T:
        return 3;
        break;
      case Tetrominoe.L:
        return 2;
        break;
      case Tetrominoe.S:
        return 3;
        break;
    }

    return 0;
  }
}
