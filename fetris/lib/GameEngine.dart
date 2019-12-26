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
    return TetrominoePosition(_randomTetrominoe(), 0, 0);
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

  Tetrominoe _randomTetrominoe() {
    int random = Random().nextInt(Tetrominoe.values.length - 1);
    return Tetrominoe.values[random];
  }
}
