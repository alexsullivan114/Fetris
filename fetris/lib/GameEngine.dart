import 'dart:math';

import 'package:fetris/TetrominoeBlock.dart';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

class GameEngine {
  double blockSize;
  double screenWidth;
  double screenHeight;
  GameState _gameState = GameState.IDLE;

  List<TetrominoeBlock> _fallenBlocks = [];
  TetrominoePosition active;

  List<TetrominoeBlock> get blocks {
    final List<TetrominoeBlock> blocks = List.from(_fallenBlocks);
    blocks.addAll(active.toTetrominoeBlocks());
    return blocks;
  }

  void initialize(double screenWidth, double screenHeight) {
    if (_gameState == GameState.IDLE) {
      _gameState = GameState.ACTIVE;
      this.screenWidth = screenWidth;
      this.screenHeight = screenHeight;
      this.blockSize = screenWidth.floor() / 8;
      active = TetrominoePosition(Tetrominoe.L, 0, 0);
    }
  }

  GameEngine tick() {
    TetrominoePosition advancedActive = _advance(active);
    if (active == advancedActive) {
      _fallenBlocks.addAll(active.toTetrominoeBlocks());
      TetrominoePosition nextActive = _generateNewTetrominoe();
      active = nextActive;
      return this;
    } else if (tetrominoePositionCollidesWithExisting(advancedActive)) {
      _fallenBlocks.addAll(active.toTetrominoeBlocks());
      TetrominoePosition nextActive = _generateNewTetrominoe();
      active = nextActive;
      return this;
    } else {
      active = advancedActive;
      return this;
    }
  }

  bool tetrominoePositionCollidesWithExisting(
      TetrominoePosition tetrominoePosition) {
    for (TetrominoeBlock existing in _fallenBlocks) {
      if (tetrominoePosition.collidesWith(existing.position)) {
        return true;
      }
    }

    return false;
  }

  GameEngine left() {
    TetrominoePosition newActive = TetrominoePosition(active.tetrominoe,
        active.verticalOffsetCount, active.horizontalOffsetCount - 1);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        active.horizontalOffsetCount > 0) {
      active = newActive;
    }

    return this;
  }

  GameEngine down() {
    TetrominoePosition newActive = _advance(active);
    if (!tetrominoePositionCollidesWithExisting(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine right() {
    int horizontalMax = (screenWidth / blockSize).floor();
    TetrominoePosition newActive = TetrominoePosition(active.tetrominoe,
        active.verticalOffsetCount, active.horizontalOffsetCount + 1);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        active.horizontalOffsetCount + _tetrominoeWidth(active.tetrominoe) <
            horizontalMax) {
      active = newActive;
    }

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
