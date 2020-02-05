import 'dart:math';

import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/game/TetrominoeBlock.dart';
import 'package:flutter/material.dart';

import 'Tetrominoe.dart';
import 'TetrominoePosition.dart';

class GameEngine {
  static const int maxHorizontalBlockCount = 8;
  static const int originalMaxVerticalBlockCount = 16;
  int maxVerticalBlockCount = originalMaxVerticalBlockCount;
  double blockSize;
  double screenWidth;
  double screenHeight;
  GameState gameState = GameState.IDLE;
  int score = 0;
  FetrisColorTheme _theme;

  FetrisColorTheme get theme => _theme;

  set theme(FetrisColorTheme theme) {
    _theme = theme;
    _fallenBlocks = _fallenBlocks
        .map((block) => TetrominoeBlock(_theme[block.originalTetrominoe],
            block.position, block.originalTetrominoe))
        .toList();

    active = TetrominoePosition(active.tetrominoe, active.coordinates,
        active.rotation, active.pivot, theme);
  }

  List<TetrominoeBlock> _fallenBlocks = [];
  TetrominoePosition active;

  List<TetrominoeBlock> get blocks {
    final List<TetrominoeBlock> blocks = [];
    blocks.addAll(_projectedFinalActive(active));
    blocks.addAll(_fallenBlocks);
    blocks.addAll(active.blocks());
    return blocks;
  }

  GameEngine(FetrisColorTheme theme) {
    _theme = theme;
    active = TetrominoePosition.fromOffset(
        Tetrominoe.STRAIGHT, 0, 0, Rotation.ZERO, theme);
  }

  void initialize(double screenWidth, double screenHeight) {
    if (gameState == GameState.IDLE) {
      gameState = GameState.ACTIVE;
      this.screenWidth = screenWidth;
      this.screenHeight = screenHeight;
      this.blockSize = screenHeight / maxVerticalBlockCount;
      this.blockSize = min(screenHeight.floor() / maxVerticalBlockCount,
          screenWidth.floor() / maxHorizontalBlockCount);
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
    List<TetrominoeBlock> updatedFallenBlocks = List.from(_fallenBlocks);
    var addedPoints = 0;
    if (tetrominoePositionCollidesWithBottom(advancedActive) ||
        tetrominoePositionCollidesWithExisting(advancedActive, updatedFallenBlocks)) {
      TetrominoePosition nextActive = _generateNewTetrominoe();
      updatedFallenBlocks.addAll(active.blocks());
      final oldLength = updatedFallenBlocks.length;
      updatedFallenBlocks = _clearCompleteLines(updatedFallenBlocks);
      final newLength = updatedFallenBlocks.length;
      addedPoints = oldLength - newLength;
      updatedFallenBlocks = _decrementBlocks(updatedFallenBlocks);
      active = _decreaseActive();
      maxVerticalBlockCount -= 1;
      if (_gameOverConditionSatisfied(nextActive, updatedFallenBlocks)) {
        gameState = GameState.DONE;
      } else {
        active = nextActive;

      }
    } else {
      active = advancedActive;
      updatedFallenBlocks = _clearCompleteLines(updatedFallenBlocks);
    }

    score += addedPoints;
    _fallenBlocks = updatedFallenBlocks;
    if (addedPoints > 0) {
      final theoreticalHeightIncrease = pow((addedPoints / maxHorizontalBlockCount).floor(), 2) + 1;
      final actualIncrease= min(theoreticalHeightIncrease, originalMaxVerticalBlockCount - maxVerticalBlockCount);
      maxVerticalBlockCount += actualIncrease;
      _fallenBlocks = _increaseHeight(actualIncrease);
    }

    return this;
  }

  bool _gameOverConditionSatisfied(TetrominoePosition nextActive, List<TetrominoeBlock> blocks) {
      if (tetrominoePositionCollidesWithExisting(nextActive, blocks)) {
        return true;
      }

      return blocks.any((block) => block.position.y < 0);
  }

  TetrominoePosition _decreaseActive() {
    final newCoordinates = active.coordinates.map((position) => Position(position.x, position.y - 1)).toList();
    return TetrominoePosition(active.tetrominoe, newCoordinates, active.rotation, active.pivot, active.theme);
  }

  List<TetrominoeBlock> _decrementBlocks(List<TetrominoeBlock> blocks) {
    return blocks.map((block) {
      final newPosition = Position(block.position.x, block.position.y - 1);
      return TetrominoeBlock(
          block.color, newPosition, block.originalTetrominoe);
    }).toList();
  }

  List<TetrominoeBlock> _increaseHeight(int increaseCount) {
    return _fallenBlocks = _fallenBlocks.map((block) {
      final newPosition =
          Position(block.position.x, block.position.y + increaseCount);
      return TetrominoeBlock(
          block.color, newPosition, block.originalTetrominoe);
    }).toList();
  }

  List<TetrominoeBlock> _clearCompleteLines(List<TetrominoeBlock> blocks) {
    final blockCountMap = Map<int, int>();
    blocks.forEach((block) {
      int y = block.position.y;
      int existingCount = blockCountMap.containsKey(y) ? blockCountMap[y] : 0;
      blockCountMap[block.position.y] = existingCount + 1;
    });

    var returnList = List<TetrominoeBlock>.from(blocks);
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
      return TetrominoeBlock(
          block.color,
          Position(blockPosition.x, blockPosition.y + numRemovedRows.length),
          block.originalTetrominoe);
    }).toList();

    return returnList;
  }

  List<TetrominoeBlock> _projectedFinalActive(TetrominoePosition active) {
    var old = active;
    while (!tetrominoePositionCollidesWithExisting(active, _fallenBlocks) &&
        !tetrominoePositionCollidesWithBottom(active)) {
      old = active;
      active = TetrominoePosition.down(active);
    }

    return old.blocks().map((block) {
      return TetrominoeBlock(Colors.grey, block.position, null);
    }).toList();
  }

  bool tetrominoePositionCollidesWithExisting(
      TetrominoePosition tetrominoePosition,
      List<TetrominoeBlock> existingBlocks) {
    for (TetrominoeBlock existing in existingBlocks) {
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
    if (!tetrominoePositionCollidesWithExisting(newActive, _fallenBlocks) &&
        !tetrominoePositionOutsideBounds(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine down() {
    var old = active;
    TetrominoePosition newActive = TetrominoePosition.down(old);
    while (!tetrominoePositionCollidesWithExisting(newActive, _fallenBlocks) &&
        !tetrominoePositionCollidesWithBottom(newActive)) {
      old = newActive;
      newActive = TetrominoePosition.down(newActive);
    }
    active = old;
    return this;
  }

  GameEngine right() {
    TetrominoePosition newActive = TetrominoePosition.right(active);
    if (!tetrominoePositionCollidesWithExisting(newActive, _fallenBlocks) &&
        !tetrominoePositionOutsideBounds(newActive)) {
      active = newActive;
    }

    return this;
  }

  GameEngine rotate() {
    TetrominoePosition newActive = TetrominoePosition.rotated(active);
    if (!tetrominoePositionCollidesWithExisting(newActive, _fallenBlocks) &&
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
