import 'Tetrominoe.dart';
import 'package:fetris/game/TetrominoePosition.dart';
import 'package:flutter/material.dart';

class TetrominoeBlock {
  final Color color;
  final Position position;
  final Tetrominoe originalTetrominoe;

  TetrominoeBlock(this.color, this.position, this.originalTetrominoe);

  @override
  String toString() {
    return 'TetrominoeBlock{color: $color, position: $position, originalTetrominoe: $originalTetrominoe}';
  }
}
