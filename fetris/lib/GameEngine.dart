import 'dart:math';

import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

class GameEngine {
  final int maxHorizontalBlockCount = 8;
  final int maxVerticalBlockCount = 16;
  double blockSize;
  double screenWidth;
  double screenHeight;
  GameState gameState = GameState.IDLE;
  int score = 0;
  FetrisColorTheme theme;

  List<TetrominoeBlock> _fallenBlocks = [];
  TetrominoePosition active;

  List<TetrominoeBlock> get blocks {
    final List<TetrominoeBlock> blocks = [];
    blocks.addAll(_projectedFinalActive(active));
    blocks.addAll(_fallenBlocks);
    blocks.addAll(active.blocks());
    return blocks;
  }

  GameEngine(this.theme);

  void initialize(double screenWidth, double screenHeight) {
    if (gameState == GameState.IDLE) {
      gameState = GameState.ACTIVE;
      this.screenWidth = screenWidth;
      this.screenHeight = screenHeight;
      this.blockSize = screenHeight / maxVerticalBlockCount;
      this.blockSize = min(screenHeight.floor() / maxVerticalBlockCount,
          screenWidth.floor() / maxHorizontalBlockCount);
      active = TetrominoePosition.fromOffset(
          Tetrominoe.STRAIGHT, 0, 0, Rotation.ZERO, theme);
    }
  }

  GameEngine restart() {
    return GameEngine(theme)..initialize(screenWidth, screenHeight);
  }

  GameEngine tick() {
    if (gameState != GameState.ACTIVE) {
      return this;
    }
    TetrominoePosition advancedActive = TetrominoePosition.down(active);
    if (tetrominoePositionCollidesWithBottom(advancedActive) ||
        tetrominoePositionCollidesWithExisting(advancedActive)) {
      TetrominoePosition nextActive = _generateNewTetrominoe();
      if (tetrominoePositionCollidesWithExisting(nextActive)) {
        gameState = GameState.DONE;
      } else {
        _fallenBlocks.addAll(active.blocks());
        active = nextActive;
      }
    } else {
      active = advancedActive;
    }

    final newList = _clearCompleteLines(_fallenBlocks);
    score += _fallenBlocks.length - newList.length;
    _fallenBlocks = newList;
    return this;
  }

  List<TetrominoeBlock> _clearCompleteLines(List<TetrominoeBlock> blocks) {
    final blockCountMap = Map<int, int>();
    blocks.forEach((block) {
      int y = block.position.y;
      int existingCount = blockCountMap.containsKey(y) ? blockCountMap[y] : 0;
      blockCountMap[block.position.y] = existingCount + 1;
    });

    var returnList = List<TetrominoeBlock>.from(_fallenBlocks);
    final List<int> removedPositions = [];
    blockCountMap.forEach((verticalPosition, count) {
      if (count >= maxHorizontalBlockCount) {
        removedPositions.add(verticalPosition);
        returnList.removeWhere((block) {
          return block.position.y == verticalPosition;
        });
      }
    });

    returnList = returnList.map((block) {
      Position blockPosition = block.position;
      final numRemovedRows = removedPositions.takeWhile((position) {
        return position > blockPosition.y;
      }).toList();
      return TetrominoeBlock(block.color,
          Position(blockPosition.x, blockPosition.y + numRemovedRows.length));
    }).toList();

    return returnList;
  }

  List<TetrominoeBlock> _projectedFinalActive(TetrominoePosition active) {
    var old = active;
    while (!tetrominoePositionCollidesWithExisting(active) &&
        !tetrominoePositionCollidesWithBottom(active)) {
      old = active;
      active = TetrominoePosition.down(active);
    }

    return old.blocks().map((block) {
      return TetrominoeBlock(Colors.grey, block.position);
    }).toList();
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
    return tetrominoePosition.coordinates.any((position) {
      return position.y > maxVerticalBlockCount - 1;
    });
  }

  bool tetrominoePositionOutsideBounds(TetrominoePosition tetrominoePosition) {
    final coordinates = tetrominoePosition.coordinates;
    for (final coordinate in coordinates) {
      if (coordinate.y < 0 ||
          coordinate.y > maxVerticalBlockCount - 1 ||
          coordinate.x < 0 ||
          coordinate.x > maxHorizontalBlockCount - 1) {
        return true;
      }
    }

    return false;
  }

  GameEngine left() {
    TetrominoePosition newActive = TetrominoePosition.left(active);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        !tetrominoePositionOutsideBounds(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine down() {
    var old = active;
    TetrominoePosition newActive = TetrominoePosition.down(old);
    while (!tetrominoePositionCollidesWithExisting(newActive) &&
        !tetrominoePositionCollidesWithBottom(newActive)) {
      old = newActive;
      newActive = TetrominoePosition.down(newActive);
    }
    active = old;
    return this;
  }

  GameEngine right() {
    TetrominoePosition newActive = TetrominoePosition.right(active);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        !tetrominoePositionOutsideBounds(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine rotate() {
    TetrominoePosition newActive = TetrominoePosition.rotated(active);
    if (!tetrominoePositionCollidesWithExisting(newActive) &&
        !tetrominoePositionOutsideBounds(newActive)) {
      active = newActive;
    }

    return this;
  }

  TetrominoePosition _generateNewTetrominoe() {
    Tetrominoe nextTetrominoe = _randomTetrominoe();
    int horizontalMax = Random().nextInt(maxHorizontalBlockCount) -
        tetrominoeWidth(nextTetrominoe);
    int horizontal = max(0, horizontalMax);
    return TetrominoePosition.fromOffset(
        nextTetrominoe, 0, horizontal, Rotation.ZERO, theme);
  }

  Tetrominoe _randomTetrominoe() {
    int random = Random().nextInt(Tetrominoe.values.length);
    return Tetrominoe.values[random];
  }
}

enum GameState { IDLE, ACTIVE, DONE }
