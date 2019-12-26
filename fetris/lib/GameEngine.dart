import 'dart:math';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

class GameEngine {
  double blockSize;
  double screenWidth;
  double screenHeight;
  GameState _gameState = GameState.IDLE;

  List<TetrominoePosition> tetrominoes = [];

  void initialize(double screenWidth, double screenHeight) {
    if (_gameState == GameState.IDLE) {
      _gameState = GameState.ACTIVE;
      this.screenWidth = screenWidth;
      this.screenHeight = screenHeight;
      this.blockSize = screenWidth.floor() / 8;
      TetrominoePosition active = TetrominoePosition(Tetrominoe.L, 0, 0);
      tetrominoes.add(active);
    }
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
    int horizontalMax = Random().nextInt((screenWidth / blockSize).floor()) -
        _tetrominoeWidth(nextTetrominoe);
    int horizontal = max(0, horizontalMax);
    return TetrominoePosition(nextTetrominoe, 0, horizontal);
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {
    int totalVerticalBlockCount = (screenHeight / blockSize).floor();
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

enum GameState { IDLE, ACTIVE, DONE }
