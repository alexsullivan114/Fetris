import 'dart:math';

import 'package:fetris/TetrominoeBlock.dart';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

class GameEngine {
  double blockSize;
  double screenWidth;
  double screenHeight;
  GameState gameState = GameState.IDLE;

  List<TetrominoeBlock> _fallenBlocks = [];
  TetrominoePosition active;

  List<TetrominoeBlock> get blocks {
    final List<TetrominoeBlock> blocks = List.from(_fallenBlocks);
    blocks.addAll(active.toTetrominoeBlocks());
    return blocks;
  }

  int get maxHorizontalBlockCount {
    return (screenWidth / blockSize).floor();
  }

  void initialize(double screenWidth, double screenHeight) {
    if (gameState == GameState.IDLE) {
      gameState = GameState.ACTIVE;
      this.screenWidth = screenWidth;
      this.screenHeight = screenHeight;
      this.blockSize = screenWidth.floor() / 8;
      active = TetrominoePosition(Tetrominoe.L, 0, 0);
    }
  }

  GameEngine tick() {
    TetrominoePosition advancedActive = _advance(active);
    if (tetrominoePositionCollidesWithBottom(advancedActive)) {
      TetrominoePosition nextActive = _generateNewTetrominoe();
      if (tetrominoePositionCollidesWithExisting(nextActive)) {
        gameState = GameState.DONE;
      } else {
        _fallenBlocks.addAll(active.toTetrominoeBlocks());
        active = nextActive;
      }
    } else if (tetrominoePositionCollidesWithExisting(advancedActive)) {
      TetrominoePosition nextActive = _generateNewTetrominoe();
      if (tetrominoePositionCollidesWithExisting(nextActive)) {
        gameState = GameState.DONE;
      } else {
        _fallenBlocks.addAll(active.toTetrominoeBlocks());
        active = nextActive;
      }
    } else {
      active = advancedActive;
    }

    _fallenBlocks = _clearCompleteLines();
    return this;
  }

  List<TetrominoeBlock> _clearCompleteLines() {
    final blockCountMap = Map<int, int>();
    _fallenBlocks.forEach((block) {
      int y = block.position.y;
      int existingCount = blockCountMap.containsKey(y) ? blockCountMap[y] : 0;
      blockCountMap[block.position.y] = existingCount + 1;
    });

    var returnList = List<TetrominoeBlock>.from(_fallenBlocks);

    blockCountMap.forEach((verticalPosition, count) {
      if (count >= maxHorizontalBlockCount) {
        returnList.removeWhere((block) {
          return block.position.y == verticalPosition;
        });
        returnList = returnList.map((block) {
          Position blockPosition = block.position;
          if (blockPosition.y < verticalPosition) {
            return TetrominoeBlock(
                block.color, Position(blockPosition.x, blockPosition.y + 1));
          } else {
            return block;
          }
        }).toList();
      }
    });

    return returnList;
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

  bool tetrominoePositionCollidesWithBottom(
      TetrominoePosition tetrominoePosition) {
    int totalVerticalBlockCount = (screenHeight / blockSize).floor();
    int height = tetrominoeHeight(tetrominoePosition.tetrominoe);
    int maxBlockCount = totalVerticalBlockCount - height;
    return tetrominoePosition.verticalOffsetCount > maxBlockCount;
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
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        !tetrominoePositionCollidesWithBottom(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine right() {
    TetrominoePosition newActive = TetrominoePosition(active.tetrominoe,
        active.verticalOffsetCount, active.horizontalOffsetCount + 1);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        active.horizontalOffsetCount + tetrominoeWidth(active.tetrominoe) <
            maxHorizontalBlockCount) {
      active = newActive;
    }

    return this;
  }

  TetrominoePosition _generateNewTetrominoe() {
    Tetrominoe nextTetrominoe = _randomTetrominoe();
    int horizontalMax = Random().nextInt(maxHorizontalBlockCount) -
        tetrominoeWidth(nextTetrominoe);
    int horizontal = max(0, horizontalMax);
    return TetrominoePosition(nextTetrominoe, 0, horizontal);
  }

  TetrominoePosition _advance(TetrominoePosition tetrominoePosition) {
    return TetrominoePosition(
        tetrominoePosition.tetrominoe,
        tetrominoePosition.verticalOffsetCount + 1,
        tetrominoePosition.horizontalOffsetCount);
  }

  Tetrominoe _randomTetrominoe() {
    int random = Random().nextInt(Tetrominoe.values.length);
    return Tetrominoe.values[random];
  }
}

enum GameState { IDLE, ACTIVE, DONE }
